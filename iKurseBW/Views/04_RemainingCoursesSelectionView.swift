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
                switch courseSelection.validity {
                case .missingMandatoryCourses(let missing):
                    Label("Fehlende Kurse", systemImage: "xmark.circle")
                        .foregroundStyle(.red)
                    ForEach(missing, id: \.self) { courseType in
                        Text(courseType.localized())
                    }
                case .notEnoughCourses:
                    Text(
                        "Du brauchst mindestens 42 Kurse (Semester eines Faches)"
                    )
                    .foregroundStyle(.red)
                case .dangerouslyLowAmountOfCourses:
                    Text(
                        "Es werden mindestens 44 Kurse empfohlen. Mit 42 Kursen besteht das Risiko, bei einer Sportverletzung oder längerer Krankheit nicht zum Abitur zugelassen zu werden."
                    )
                    .foregroundStyle(.orange)
                default:
                    Label(
                        "Alle Kurse ausgewählt!",
                        systemImage: "checkmark.circle"
                    )
                    .foregroundColor(.green)
                    NavigationLink("Weiter") {
                        ResultView()
                    }
                }
                Text("\(courseSelection.totalSemesters) Kurse gwählt")
                HStack {
                    Text("Summe")
                    Spacer()
                    Text(
                        "\(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[0] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[1] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[2] }) \(courseSelection.allSelectedCourses.reduce(0) { $0 + $1.lessonsPerWeek[3] })"
                    )
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
