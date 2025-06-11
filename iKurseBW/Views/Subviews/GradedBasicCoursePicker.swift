//
//  GradedBasicCoursePicker.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

struct GradedBasicCoursePicker: View {
    @State var selectedCourse = ""
    @Environment(CourseSelection.self) var courseSelection
    let index: Int
    var body: some View {
        Picker("Mündlich geprüfter Basiskurs \(index + 1)", selection: $selectedCourse) {
            Text("Bitte auswählen!").tag("")
            if let forced = courseSelection.forcedBasicGradings[safe: index] {
                if forced == .german {
                    Text("Deutsch").tag("Deutsch")
                } else if forced == .math {
                    Text("Mathematik").tag("Mathematik")
                } else if forced == .social {
                    ForEach(courseSelection.availableCourses.filter({ $0.attributes.contains(.social) })) { course in
                        Text(course.name).tag(course.name)
                    }
                }
            } else {
                ForEach(
                    courseSelection.availableCourses.filter({
                        $0.isAvailableForOralGrading(
                            performers: courseSelection.performerCourses.compactMap({$0}).filter({ $0.name != selectedCourse }),
                        )
                    })
                ) { course in
                    Text(course.name).tag(course.name)
                }
            }
        }
        .onChange(of: selectedCourse) {
            courseSelection.gradedBasicCourses[index] = courseSelection.availableCourses.first(where: {
                $0.name == selectedCourse
            }) ?? nil
        }
}

#Preview {
    @Previewable @State var gradedBasicCourses: [Course?] = [nil , nil]
    GradedBasicCoursePicker(index: 0)
}
