//
//  GradedBasicCourseSelectionView.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

struct GradedBasicCourseSelectionView: View {
    @Environment(CourseSelection.self) var courseSelection
    let lastPerformerCourse: Course
    var body: some View {
        Form {
            Text("Nun wähle deine geprüften Basiskurse. Einer oder zwei können durch deine Leistungsfachwahl vorgegeben sein.")
            GradedBasicCoursePicker(index: 0)
            GradedBasicCoursePicker(index: 1)
            NavigationLink("Verbleibende Kurse wählen", destination: RemainingCoursesSelectionView())
            .disabled(
                courseSelection.gradedBasicCourses.contains(nil)
            )
        }
        .onAppear {
            courseSelection.performerCourses[2] = lastPerformerCourse
        }
        .navigationTitle("Geprüfte Basiskurse")
    }
}

#Preview {
    NavigationStack {
        GradedBasicCourseSelectionView(lastPerformerCourse: Course(name: "Mathematik", lessonsPerWeek: [3,3,3,3], attributes: [.math], field: .science))
            .environment(CourseSelection())
    }
}
