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
    var german: String {
        courseSelection.availableCourses.first(where: {
            $0.attributes.contains(.german)
        })?.name ?? "Deutsch"
    }
    var math: String {
        courseSelection.availableCourses.first(where: {
            $0.attributes.contains(.math)
        })?.name ?? "Mathematik"
    }
    var body: some View {
        Picker(
            "Mündlich geprüfter Basiskurs \(index + 1)",
            selection: $selectedCourse
        ) {
            if selectedCourse == "" {
                Text(
                    "Bitte auswählen",
                    comment:
                        "The default picker element when no course is selected"
                ).tag("").disabled(true)
            }
            if let forced = courseSelection.forcedBasicGradings[safe: index] {
                if forced == .german {
                    Text(german).tag(german)
                } else if forced == .math {
                    Text(math).tag(math)
                } else if forced == .social {
                    ForEach(
                        courseSelection.availableCourses.filter({
                            $0.attributes.contains(.social)
                        })
                    ) { course in
                        Text(course.name).tag(course.name)
                    }
                }
            } else {
                ForEach(
                    courseSelection.availableCourses.filter({ course in
                        course.isAvailableForOralGrading(
                            performers: courseSelection.performerCourses
                                .compactMap({ $0 }).filter({
                                    $0.name != selectedCourse
                                }),
                        )
                            && !courseSelection.forcedBasicGradings.contains(
                                where: { course.attributes.contains($0) })
                    })
                ) { course in
                    Text(course.name).tag(course.name)
                }
            }
        }
        .onChange(of: selectedCourse) {
            courseSelection.gradedBasicCourses[index] =
                courseSelection.availableCourses.first(where: {
                    $0.name == selectedCourse
                }) ?? nil
        }
    }
}

#Preview {
    @Previewable @State var gradedBasicCourses: [Course?] = [nil, nil]
    GradedBasicCoursePicker(index: 0)
}
