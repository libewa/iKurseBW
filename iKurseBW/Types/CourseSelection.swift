//
//  CourseSelection.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

let mandatoryCourses: Set<CourseAttribute> = [.german, .math, .foreignLanguage, .science, .history, .socialStudies, .geography, .religion, .artMusic, .sports]

@Observable class CourseSelection: Codable {
    var availableCourses: [Course]
    var performerCourses: [Course?]
    var gradedBasicCourses: [Course?]
    var basicCourses: [Course]

    var languageCourses: [Course] {
        availableCourses.filter { $0.field == .language }
    }
    var socialCourses: [Course] {
        availableCourses.filter { $0.field == .social }
    }
    var scienceCourses: [Course] {
        availableCourses.filter { $0.field == .science }
    }
    var sportsCourses: [Course] {
        availableCourses.filter { $0.field == .sports }
    }

    var allSelectedCourses: [Course] {
        performerCourses.compactMap({ $0 })
            + gradedBasicCourses.compactMap({ $0 }) + basicCourses
    }

    init() {
        self.performerCourses = [nil, nil, nil]
        self.gradedBasicCourses = [nil, nil]
        self.basicCourses = []

        let decoder = JSONDecoder()
        let coursesData = try! Data(
            contentsOf: Bundle.main.url(
                forResource: "courses",
                withExtension: "json"
            )!
        )
        print(String(data: coursesData, encoding: .utf8)!)
        self.availableCourses = try! decoder.decode(
            [Course].self,
            from: coursesData
        )
    }

    var forcedBasicGradings: [CourseAttribute] {
        var forced: [CourseAttribute] = []
        if !self.performerCourses.contains(where: {
            $0?.attributes.contains(.german) ?? false
        }) {
            forced.append(.german)
        }
        if !self.performerCourses.contains(where: {
            $0?.attributes.contains(.math) ?? false
        }) {
            forced.append(.math)
        }
        if !self.performerCourses.contains(where: {
            $0?.attributes.contains(.social) ?? false
        }) {
            forced.append(.social)
        }
        return forced
    }

    var missingMandatoryCourses: [CourseAttribute] {
        var missing = mandatoryCourses.subtracting(allSelectedCourses.flatMap {
            $0.attributes.contains(.inDepthCourse) ? [] : $0.attributes
        })
        //TODO: Allow not selecting a sports course, but give out a warning.
        
        if !missing.contains(.science) {
            var coursesWithoutFirstScience = allSelectedCourses
            coursesWithoutFirstScience.remove(at: coursesWithoutFirstScience.firstIndex(where: { $0.attributes.contains(.science) })!)
            if !coursesWithoutFirstScience.contains(where: { $0.attributes.contains(.newScience) || $0.attributes.contains(.science) }) {
                var coursesWithoutFirstForeignLanguage = allSelectedCourses
                coursesWithoutFirstForeignLanguage.remove(at: coursesWithoutFirstForeignLanguage.firstIndex(where: { $0.attributes.contains(.foreignLanguage) })!)
                if !coursesWithoutFirstForeignLanguage.contains(where: { $0.attributes.contains(.foreignLanguage) }) {
                    missing.insert(.newScience)
                }
            }
        }
        return Array(missing)
    }

    var lessonsPerWeek: [Int] {
        return [
            self.allSelectedCourses.reduce(0) {
                $0 + (performerCourses.contains($1) ? 5 : $1.lessonsPerWeek[0])
            },
            self.allSelectedCourses.reduce(0) {
                $0 + (performerCourses.contains($1) ? 5 : $1.lessonsPerWeek[1])
            },
            self.allSelectedCourses.reduce(0) {
                $0 + (performerCourses.contains($1) ? 5 : $1.lessonsPerWeek[2])
            },
            self.allSelectedCourses.reduce(0) {
                $0 + (performerCourses.contains($1) ? 5 : $1.lessonsPerWeek[3])
            },
        ]
    }

    var totalSemesters: Int {
        allSelectedCourses.reduce(0) { total, course in
            total + course.lessonsPerWeek.reduce(0) { $0 + ($1 > 0 ? 1 : 0) }
        }
    }

    enum ValidityCheckResult {
        case valid
        case missingPerformerCourses
        case missingGradedBasicCourses
        case missingMandatoryCourses([CourseAttribute])
        case notEnoughCourses
        case dangerouslyLowAmountOfCourses
    }

    var validity: ValidityCheckResult {
        guard !performerCourses.contains(nil) else {
            return .missingPerformerCourses
        }
        guard !gradedBasicCourses.contains(nil) else {
            return .missingGradedBasicCourses
        }
        if !self.missingMandatoryCourses.isEmpty {
            return .missingMandatoryCourses(self.missingMandatoryCourses)
        }
        if self.totalSemesters < 44 {
            if self.totalSemesters < 42 {
                return .notEnoughCourses
            } else {
                return .dangerouslyLowAmountOfCourses
            }
        }
        return .valid
    }

    var availablePerformerCourses: [Course] {
        self.availableCourses.compactMap { $0 }.filter {
            $0.isValidPerformerCourse(performers: self.performerCourses)
        }
    }

    func addMissingUnambiguousCourses() {
        for attribute in self.missingMandatoryCourses {
            let candidates = self.availableCourses.filter {
                $0.attributes.contains(attribute) && !$0.attributes.contains(.inDepthCourse)
            }
            if candidates.count == 1 {
                let course = candidates[0]
                self.basicCourses.append(course)
            }
        }
    }

    var export: String {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        return String(data: data, encoding: .utf8)!
    }
}
