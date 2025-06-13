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
        List {
            Section {
                if let missing = courseSelection.missingMandatoryCourses {
                    Label("Fehlende Kurse", systemImage: "xmark.circle")
                        .foregroundColor(.red)
                    ForEach(missing, id: \.self) { courseType in
                        Text(courseType.localized())
                    }
                } else {
                    Label(
                        "Alle Kurse ausgewählt!",
                        systemImage: "checkmark.circle"
                    )
                    .foregroundColor(.green)
                    //TODO: Export selected courses
                    /*
                     ShareLink(
                     item: courseSelection.export,
                     label: {
                     Label(
                     "Exportieren",
                     systemImage: "square.and.arrow.up"
                     )
                     },
                     )*/
                }
            }
            Section("Aufgabenfeld 1 (Sprache/Kunst)") {
                ForEach(courseSelection.languageCourses) { course in
                    RemainingCourseSelectionLineStack(course: course)
                }
            }
            Section("Aufgabenfeld 2 (Gesellschaft)") {
                ForEach(courseSelection.socialCourses) { course in
                    RemainingCourseSelectionLineStack(course: course)
                }
            }
            Section("Aufgabenfeld 3 (Mathematik/Naturwissenschaften)") {
                ForEach(courseSelection.scienceCourses) { course in
                    RemainingCourseSelectionLineStack(course: course)
                }
            }
            Section("Sport") {
                ForEach(courseSelection.sportsCourses) { course in
                    RemainingCourseSelectionLineStack(course: course)
                }
            }
            
            HStack {
                Text("Summe")
                Spacer()
                Text(
                    "\(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[0] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[1] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[2] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[3] })"
                )
                .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
        }
        .onAppear {
            courseSelection.addMissingUnambiguousCourses()
        }
    }
}

#Preview {
    NavigationStack {
        RemainingCoursesSelectionView()
            .environment(CourseSelection())
    }
}
