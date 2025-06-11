//
//  GradedBasicCourseSelectionView.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

struct GradedBasicCourseSelectionView: View {
    @Environment(CourseSelection.self) var courseSelection
    var body: some View {
        VStack {
            GradedBasicCoursePicker(index: 0)
            GradedBasicCoursePicker(index: 1)
            NavigationLink("Verbleibende Kurse wählen", destination: RemainingCoursesSelectionView())
            .disabled(
                courseSelection.gradedBasicCourses.contains(nil)
            )
        }
    }
}

#Preview {
    GradedBasicCourseSelectionView()
        .environment(CourseSelection())
        .padding()
}
