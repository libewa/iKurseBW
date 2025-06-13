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
                    FullCourseSelectionLineStack(course: course)
                }
                HStack {
                    Text("Summe")
                    Spacer()
                    Text("\(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[0] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[1] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[2] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[3] })")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                }
            }
            List {
                if let missing = courseSelection.missingCourses {
                    Label("Fehlende Kurse: \(missing.joined(separator: ", "))", systemImage: "xmark.circle")
                    .foregroundColor(.red)
                    ForEach(missing, id: \.self) { courseType in
                        Text(courseType.rawValue)
                    }
                } else {
                    Label("Alle Kurse ausgewählt!", systemImage: "checkmark.circle")
                        .foregroundColor(.green)
                    //TODO: Export selected courses
                }
            }
        }
    }
}

#Preview {
    RemainingCoursesSelectionView()
}
