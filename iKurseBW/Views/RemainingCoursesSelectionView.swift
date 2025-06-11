//
//  RemainingCoursesSelectionView.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

struct RemainingCoursesSelectionView: View {
    @Environment(CourseSelection.self) var courseSelection
    var body: some View {
        List(0..<courseSelection.missingGradedCourses.count) { i in
            Text("\(i): \(courseSelection.availableCourses[i].name)")
        }
    }
}

#Preview {
    RemainingCoursesSelectionView()
}
