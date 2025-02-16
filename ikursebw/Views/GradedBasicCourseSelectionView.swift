//
//  BasicCourseSelectionView.swift
//  ikursebw
//
//  Created by Linus Warnatz on 15.02.25.
//

import SwiftUI

enum GradedBasicCourseType {
    case social, math, german
    case free
}

let forcedBasicGradings: [[CourseAttribute]: (GradedBasicCourseType, GradedBasicCourseType)] = [
    [.german, .math, .foreignLanguage]: (.social, .free),
    [.german, .math, .science]: (.social, .free),
    [.german, .math, .social]: (.free, .free),
    [.german, .math, .artMusicSports]: (.social, .free),
    
    [.german, .foreignLanguage, .math]: (.social, .free),
    [.german, .foreignLanguage, .foreignLanguage]: (.math, .free),
]

struct GradedBasicCourseSelectionView: View {
    let availableCourses: [Course]
    @State var forcedGradedBasicCourses: (GradedBasicCourseType, GradedBasicCourseType) = (.free, .free)
    @State var gradedBasicCourses: (Course, Course) = (Course(name: "", lessonsPerWeek: [0, 0, 0, 0], attributes: [.noPerformerCourse], field: .elective), Course(name: "", lessonsPerWeek: [0, 0, 0, 0], attributes: [.noPerformerCourse], field: .elective))
    var performerCourseSelection: [CourseAttribute]
    var body: some View {
        VStack {
            Text("2 deiner Basiskurse werden mündlich geprüft. Manchmal sind sie durch deine LK-Wahl vorgegeben, manchmal kannst du sie frei wählen.")
                .onAppear {
                    if let forcedGrading = forcedBasicGradings[performerCourseSelection] {
                        self.forcedGradedBasicCourses = forcedGrading
                    } else {
                        self.forcedGradedBasicCourses = (.free, .free)
                    }
                }
            Picker("Mündlich geprüfter Basiskurs 1", selection: $gradedBasicCourses.0) {
                if forcedGradedBasicCourses.0 == .social {
                    ForEach(
                        availableCourses.filter(
                            { course in
                                course.attributes.contains(.social)
                            }
                        )
                    ) { course in
                        Text(course.name).tag(course)
                    }
                } else if forcedGradedBasicCourses.0 == .math {
                    Text("Mathematik").tag(availableCourses.first(where: { $0.attributes.contains(.math) })!).disabled(true)
                } else if forcedGradedBasicCourses.0 == .german {
                    Text("Deutsch").tag(availableCourses.first(where: { $0.attributes.contains(.german) })!).disabled(true)
                } else {
                    ForEach(availableCourses.filter({ course in
                        //TODO: You shouldn't be able to select your performer courses as graded basic courses
                        if !course.oralGradingAvailable() {
                            return false
                        }
                        if course == gradedBasicCourses.0 {
                            return false
                        }
                        return true
                    })) { course in
                        Text(course.name).tag(course)
                    }
                }
            }
            Picker("Mündlich geprüfter Basiskurs 2", selection: $gradedBasicCourses.1) {
                if forcedGradedBasicCourses.1 == .social {
                    ForEach(
                        availableCourses.filter(
                            { course in
                                course.attributes.contains(.social) && course.oralGradingAvailable()
                            }
                        )
                    ) { course in
                        Text(course.name).tag(course)
                    }
                } else if forcedGradedBasicCourses.1 == .math {
                    Text("Mathematik").tag(availableCourses.first(where: { $0.attributes.contains(.math) })!).disabled(true)
                } else if forcedGradedBasicCourses.1 == .german {
                    Text("Deutsch").tag(availableCourses.first(where: { $0.attributes.contains(.german) })!).disabled(true)
                } else {
                    ForEach(availableCourses.filter({ course in
                        if !course.oralGradingAvailable() {
                            return false
                        }
                        if course == gradedBasicCourses.0 {
                            return false
                        }
                        return true
                    })) { course in
                        Text(course.name).tag(course)
                    }
                }
            }
        }
    }
    
    mutating func setGradedBasicCourses(for selection: [CourseAttribute]) {
        if let forcedGrading = forcedBasicGradings[selection] {
            self.forcedGradedBasicCourses = forcedGrading
        } else {
            self.forcedGradedBasicCourses = (.free, .free)
        }
    }
}

#Preview {
    let courses = try! JSONDecoder().decode([Course].self, from: try! Data(contentsOf: Bundle.main.url(forResource: "courses", withExtension: "json")!))
    GradedBasicCourseSelectionView(availableCourses: courses, performerCourseSelection: [.german, .math, .foreignLanguage])
}
