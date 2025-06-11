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
}
