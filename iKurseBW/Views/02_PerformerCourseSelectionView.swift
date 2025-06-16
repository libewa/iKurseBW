//
//  PerformerCourseSelectionView.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

struct PerformerCourseSelectionView: View {
    @Environment(CourseSelection.self) var courseSelection
    @State private var selectedCourse = ""
    let index: Int
    let previousSelection: Course?
    var body: some View {
        List {
            Text(.wähleLeistungskursErklärung(index + 1)
            )
            ForEach(
                courseSelection.availablePerformerCourses
            ) { course in
                NavigationLink {
                    if index >= 2 {
                        GradedBasicCourseSelectionView(
                            lastPerformerCourse: course
                        )
                    } else {
                        PerformerCourseSelectionView(
                            index: index + 1,
                            previousSelection: course
                        )
                    }
                } label: {
                    HStack {
                        Text(course.name)
                        #if os(macOS)
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundStyle(.secondary)
                        #endif
                    }
                }
            }
        }
        .onChange(of: selectedCourse) {
            courseSelection.performerCourses[index] =
                courseSelection.availableCourses.first(where: {
                    $0.name == selectedCourse
                }) ?? nil
        }
        .onAppear {
            if let previous = previousSelection {
                courseSelection.performerCourses[index - 1] = previous
            }
        }
        .navigationTitle(.leistungskurse3(index + 1))
    }
}

#Preview {
    NavigationStack {
        PerformerCourseSelectionView(index: 0, previousSelection: nil)
            .environment(CourseSelection())
    }
}
