//
//  OtherCourseSelectorView.swift
//  ikursebw
//
//  Created by Linus Warnatz on 16.02.25.
//

import SwiftUI

struct OtherCourseSelectionView: View {
    @Environment(CourseSelection.self) var courseSelection: CourseSelection
    let availableCourses: [Course]
    var body: some View {
        VStack {
            Text("Nun musst du weitere Kurse wählen, bis du insgesamt 42 Kurse über alle vier Halbjahre besuchst.")
            List(availableCourses.filter({ course in
                if courseSelection.performerCourses.contains(course) {
                    return false
                }
                if courseSelection.gradedBasicCourses.contains(course) {
                    return false
                }
                return true
            }).sorted(by: { lhs, rhs in
                lhs.field.rawValue < rhs.field.rawValue
            })) { course in
                HStack {
                    Text("\(course.name)")
                    Spacer()
                    if !courseSelection.basicCourses.contains(course) {
                        Button("Wählen") {
                            courseSelection.basicCourses.append(course)
                            print(courseSelection.basicCourses)
                        }
                        .disabled(!canStillChoose(course: course))
                    } else {
                        Button("Abwählen") {
                            courseSelection.basicCourses.removeAll(where: { $0 == course })
                            print(courseSelection.basicCourses)
                        }
                    }
                    /*
                    Text("\(course.lessonsPerWeek[0])")
                    Text("\(course.lessonsPerWeek[1])")
                    Text("\(course.lessonsPerWeek[2])")
                    Text("\(course.lessonsPerWeek[3])")
                     */
                }
            }
        }
        .onAppear {
            print(courseSelection.performerCourses)
            print(courseSelection.gradedBasicCourses)
            print(courseSelection.basicCourses)
        }
    }
    func canStillChoose(course: Course) -> Bool {
        if course.attributes.contains(.religion) && courseSelection.basicCourses.contains(where: { $0.attributes.contains(.religion) }) {
            return false
        }
        if course.attributes.contains(.seminarCourse) && courseSelection.basicCourses.contains(where: { $0.attributes.contains(.seminarCourse) }) {
            return false
        }
        return true
    }
}

#Preview {
    let courses = try! JSONDecoder().decode([Course].self, from: try! Data(contentsOf: Bundle.main.url(forResource: "courses", withExtension: "json")!))
    OtherCourseSelectionView(availableCourses: courses)
        .environment(CourseSelection(performerCourses: [Course(name: "Deutsch", lessonsPerWeek: [3, 3, 3, 3], attributes: [.german], field: .language)], gradedBasicCourses: [Course(name: "Englisch", lessonsPerWeek: [3, 3, 3, 3], attributes: [.foreignLanguage], field: .language)], basicCourses: []))
}
