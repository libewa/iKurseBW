//
//  CourseSelection.swift
//  ikursebw
//
//  Created by Linus Warnatz on 16.02.25.
//

import SwiftUI

@Observable class CourseSelection {
    var performerCourses: [Course?]
    var gradedBasicCourses: [Course?]
    var basicCourses: [Course]
    
    init(performerCourses: [Course], gradedBasicCourses: [Course], basicCourses: [Course]) {
        self.performerCourses = performerCourses
        self.gradedBasicCourses = gradedBasicCourses
        self.basicCourses = basicCourses
    }
    init(basicCourses: [Course]) {
        self.performerCourses = [nil, nil, nil]
        self.gradedBasicCourses = [nil, nil]
        self.basicCourses = basicCourses
    }
    
    func isValid() -> Bool {
        let allCourses = self.performerCourses + self.gradedBasicCourses + self.basicCourses
        if !(
            allCourses.contains(where: {$0.attributes.contains(.german)}) &&
            allCourses.contains(where: {$0.attributes.contains(.foreignLanguage)}) &&
            allCourses.contains(where: {$0.attributes.contains(.artMusic)}) &&
            allCourses.contains(where: {$0.attributes.contains(.social)}) &&
            allCourses.contains(where: {$0.attributes.contains(.math)}) &&
            allCourses.contains(where: {
                $0.attributes.contains(.science) && !$0.attributes.contains(.newScience)
            }) &&
            allCourses.contains(where: {$0.attributes.contains(.sports)}) &&
        ) {
            return false
        }
        //TODO: Check for second EITHER foreignLanguage OR science (including newScience)
        return true
    }
}
