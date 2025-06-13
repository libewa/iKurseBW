//
//  05_ResultView.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 13.06.25.
//

import SwiftUI

struct ResultView: View {
    @Environment(CourseSelection.self) var courseSelection
    var body: some View {
        List {
            Section {
                ForEach(courseSelection.allSelectedCourses) { course in
                    CourseTableLine(course: course, locked: true)
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
            HStack {
                Text("Summe")
                Spacer()
                Text(
                    "\(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[0] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[1] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[2] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[3] })"
                )
                .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
        }
        .navigationTitle("Deine Kurswahl")
    }
}

#Preview {
    ResultView()
        .environment(CourseSelection())
}
