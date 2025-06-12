//
//  CourseSelectin.swift
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
        self.availableCourses = try! JSONDecoder().decode([Course].self, from: try! Data(contentsOf: Bundle.main.url(forResource: "courses", withExtension: "json")!))
    }

    var forcedBasicGradings: [CourseAttribute] {
        var forced: [CourseAttribute] = []
        if !self.performerCourses.contains(where: { $0.attributes.contains(.german) }) {
            forced.append(.german)
        }
        if !self.performerCourses.contains(where: { $0.attributes.contains(.math) }) {
            forced.append(.math)
        }
        if !self.performerCourses.contains(where: { $0.attributes.contains(.social) }) {
            forced.append(.social)
        }
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
    }
}
