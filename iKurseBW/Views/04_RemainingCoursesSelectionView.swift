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
        VStack {
            List {
                ForEach(courseSelection.availableCourses) { course in
                    RemainingCourseSelectionLineStack(course: course)
                }
            }
            List {
                if let missing = courseSelection.missingMandatoryCourses {
                    Label("Fehlende Kurse", systemImage: "xmark.circle")
                    .foregroundColor(.red)
                    ForEach(missing, id: \.self) { courseType in
                        Text(courseType.localized())
                    }
                } else {
                    Label("Alle Kurse ausgewählt!", systemImage: "checkmark.circle")
                        .foregroundColor(.green)
                    //TODO: Export selected courses
                }
                HStack {
                    Text("Summe")
                    Spacer()
                    Text("\(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[0] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[1] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[2] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[3] })")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                }
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
