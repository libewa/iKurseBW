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
            Text(
                "Wähle deinen \(index + 1). Leistungskurs. Die Leistungskurse werden im Abitur schriftlich geprüft und während der gesamten Kursstufe mit 5 Wochenstunden unterrichtet. Deine Leistungskurswahl kann auch die Wahl deiner mündlich geprüften Basiskurse beeinflussen."
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
        .navigationTitle("Leistungskurse (\(index + 1)/3)")
    }
}

#Preview {
    NavigationStack {
        PerformerCourseSelectionView(index: 0, previousSelection: nil)
            .environment(CourseSelection())
    }
}
