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
                //TODO: Have tvOS scroll up here even though it's not a button (low priority, just for fun)
                CourseSelectionWarningView(validity: courseSelection.validity)
                Text("\(courseSelection.totalSemesters) Kurse gwählt")
                HStack {
                    Text("Summe")
                    Spacer()
                    Text(verbatim: "\(courseSelection.lessonsPerWeek[0]) \(courseSelection.lessonsPerWeek[1]) \(courseSelection.lessonsPerWeek[2]) \(courseSelection.lessonsPerWeek[3])")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                }
            }
            Section("Aufgabenfeld 1 (Sprache/Kunst)") {
                ForEach(courseSelection.languageCourses) { course in
                    CourseTableLine(course: course, locked: false)
                }
            }
            Section("Aufgabenfeld 2 (Gesellschaft)") {
                ForEach(courseSelection.socialCourses) { course in
                    CourseTableLine(course: course, locked: false)
                }
            }
            Section("Aufgabenfeld 3 (Mathematik/Naturwissenschaften)") {
                ForEach(courseSelection.scienceCourses) { course in
                    CourseTableLine(course: course, locked: false)
                }
            }
            Section("Sport") {
                ForEach(courseSelection.sportsCourses) { course in
                    CourseTableLine(course: course, locked: false)
                }
            }
        }
        .onAppear {
            courseSelection.addMissingUnambiguousCourses()
        }
        .navigationTitle("Weitere Kurse wählen")
    }
}

#Preview {
    NavigationStack {
        RemainingCoursesSelectionView()
            .environment(CourseSelection())
    }
}
