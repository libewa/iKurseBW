//
//  CourseSelection.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

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

    var missingMandatoryCourses: [CourseAttribute]? {
        var missing: [CourseAttribute] = []
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.german)
        }) {
            missing.append(.german)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.math)
        }) {
            missing.append(.math)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.foreignLanguage)
        }) {
            missing.append(.foreignLanguage)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.science)
        }) {
            missing.append(.science)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.history)
        }) {
            missing.append(.history)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.socialStudies)
        }) {
            missing.append(.socialStudies)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.geography)
        }) {
            missing.append(.geography)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.religion)
        }) {
            missing.append(.religion)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.artMusic)
        }) {
            missing.append(.artMusic)
        }
        if !self.allSelectedCourses.contains(where: {
            $0.attributes.contains(.sports)
        }) {
            missing.append(.sports)
        }
        if missing.isEmpty {
            return nil
        }
        return missing
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
        if let missing = self.missingMandatoryCourses {
            return .missingMandatoryCourses(missing)
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
        guard let missing = self.missingMandatoryCourses else { return }
        for attribute in missing {
            let candidates = self.availableCourses.filter {
                $0.attributes.contains(attribute)
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
