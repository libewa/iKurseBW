//
//  CourseSelection.swift
//  ikursebw
//
//  Created by Linus Warnatz on 16.02.25.
//

import SwiftUI

@Observable class CourseSelection {
    var performerCourses: [Course]
    var gradedBasicCourses: [Course]
    var basicCourses: [Course]
    
    init(performerCourses: [Course], gradedBasicCourses: [Course], basicCourses: [Course]) {
        self.performerCourses = performerCourses
        self.gradedBasicCourses = gradedBasicCourses
        self.basicCourses = basicCourses
    }
}
