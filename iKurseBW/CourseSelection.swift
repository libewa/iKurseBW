//
//  CourseSelection.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

@Observable class CourseSelection {
    let availableCourses: [Course]
    var performerCourses: [Course?]
    var gradedBasicCourses: [Course?]
    var basicCourses: [Course]
    
    var allSelectedCourses: [Course] {
        performerCourses.compactMap({$0}) + gradedBasicCourses.compactMap({$0}) + basicCourses
    }
    
    init() {
        self.performerCourses = [nil, nil, nil]
        self.gradedBasicCourses = [nil, nil]
        self.basicCourses = []
        
        let decoder = JSONDecoder()
        let coursesData = try! Data(contentsOf: Bundle.main.url(forResource: "courses", withExtension: "json")!)
        print(String(data: coursesData, encoding: .utf8)!)
        self.availableCourses = try! decoder.decode([Course].self, from: coursesData)
    }

    var forcedBasicGradings: [CourseAttribute] {
        var forced: [CourseAttribute] = []
        if !self.performerCourses.contains(where: { $0?.attributes.contains(.german) ?? false }) {
            forced.append(.german)
        }
        if !self.performerCourses.contains(where: { $0?.attributes.contains(.math) ?? false }) {
            forced.append(.math)
        }
        if !self.performerCourses.contains(where: { $0?.attributes.contains(.social) ?? false }) {
            forced.append(.social)
        }
        return forced
    }

    var missingMandatoryCourses: [CourseAttribute]? {
        var missing: [CourseAttribute] = []
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.german) }) {
            missing.append(.german)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.math) }) {
            missing.append(.math)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.foreignLanguage) }) {
            missing.append(.foreignLanguage)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.science) }) {
            missing.append(.science)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.history) }) {
            missing.append(.history)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.socialStudies) }) {
            missing.append(.socialStudies)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.geography) }) {
            missing.append(.geography)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.religion) }) {
            missing.append(.religion)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.artMusic) }) {
            missing.append(.artMusic)
        }
        if !self.allSelectedCourses.contains(where: { $0.attributes.contains(.sports) }) {
            missing.append(.sports)
        }
        if missing.isEmpty {
            return nil
        }
        return missing
    }

    var isValid: Bool {
        guard !performerCourses.contains(nil) else { return false }
        guard !gradedBasicCourses.contains(nil) else { return false }
        guard missingMandatoryCourses == nil else { return false }
        return true
    }
    
    var availablePerformerCourses: [Course] {
        self.availableCourses.compactMap { $0 }.filter { $0.isValidPerformerCourse(performers: self.performerCourses) }
    }
    
    func addMissingUnambiguousCourses() {
        guard let missing = self.missingMandatoryCourses else { return }
        for attribute in missing {
            let candidates = self.availableCourses.filter { $0.attributes.contains(attribute) }
            if candidates.count == 1 {
                let course = candidates[0]
                self.basicCourses.append(course)
            }
        }
    }
}

