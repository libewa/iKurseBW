//
//  PerformerCourseSelectionView.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

struct PerformerCourseSelectionView: View {
    @Environment(CourseSelection.self) var courseSelection
    let index: Int
    var body: some View {
        VStack {
            Text("Wähle deinen \(index + 1). LK")
            PerformerCoursePicker(index: index, titleKey: "")
                .pickerStyle(.radioGroup)
            if index != 2 {
                NavigationLink(
                    "Weiter",
                    destination: PerformerCourseSelectionView(index: index + 1)
                )
                .disabled(courseSelection.performerCourses[index] == nil)
            } else {
                NavigationLink(
                    "Weiter",
                    destination: GradedBasicCourseSelectionView()
                )
            }
        }
        .padding()
        .navigationTitle("Leistungskurse (\(index + 1)/3)")
    }
}

#Preview {
    PerformerCourseSelectionView(index: 0)
        .environment(CourseSelection())
}
