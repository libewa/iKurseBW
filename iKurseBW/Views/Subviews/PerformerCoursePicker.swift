//
//  PerformerCoursePicker.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//
import SwiftUI

struct PerformerCoursePicker: View {
    @State private var selectedCourse = ""
    @Environment(CourseSelection.self) var courseSelection
    let index: Int
    let titleKey: LocalizedStringKey
    var body: some View {
        Picker(titleKey, selection: $selectedCourse) {
            if selectedCourse == "" {
                Text("Bitte auswählen").tag("").disabled(true)
            }
            ForEach(
                courseSelection.performerCourses.filter { $0.isValidPerformerCourse(performers: courseSelection.performerCourses) || $0.name == selectedCourse }
            ) { course in
                Text(course.name).tag(course.name)
            }
        }
        .onChange(of: selectedCourse) {
            courseSelection.performerCourses[index] = courseSelection.availableCourses.first(where: {
                $0.name == selectedCourse
            }) ?? nil
        }
    }
}

#Preview {
    @Previewable @State var performers = InlineArray<3, Course?>(repeating: nil)
    PerformerCoursePicker(index: 0, titleKey: "LK 1")
        .environment(CourseSelection())
        .padding()
}
