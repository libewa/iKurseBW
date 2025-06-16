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
                Text(.kurseGwählt(courseSelection.totalSemesters))
                HStack {
                    Text(.summe)
                    Spacer()
                    Text(verbatim: "\(courseSelection.lessonsPerWeek[0]) \(courseSelection.lessonsPerWeek[1]) \(courseSelection.lessonsPerWeek[2]) \(courseSelection.lessonsPerWeek[3])")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                }
            }
            Section(.aufgabenfeld1) {
                ForEach(courseSelection.languageCourses) { course in
                    CourseTableLine(course: course, locked: false)
                }
            }
            Section(.aufgabenfeld2) {
                ForEach(courseSelection.socialCourses) { course in
                    CourseTableLine(course: course, locked: false)
                }
            }
            Section(.aufgabenfeld3) {
                ForEach(courseSelection.scienceCourses) { course in
                    CourseTableLine(course: course, locked: false)
                }
            }
            Section(.sport) {
                ForEach(courseSelection.sportsCourses) { course in
                    CourseTableLine(course: course, locked: false)
                }
            }
        }
        .onAppear {
            courseSelection.addMissingUnambiguousCourses()
        }
        .navigationTitle(.weitereKurseWählen)
    }
}

#Preview {
    NavigationStack {
        RemainingCoursesSelectionView()
            .environment(CourseSelection())
    }
}
