//
//  PerformCourseSelectionView.swift
//  ikursebw
//
//  Created by Linus Warnatz on 15.02.25.
//

import SwiftUI

struct PerformerCourseSelectionView: View {
    @Environment(CourseSelection.self) var courseSelection
    let availableCourses: [Course]
    @State var performer1: CourseAttribute = .german
    @State var performer2: CourseAttribute = .math
    @State var performer3: CourseAttribute = .foreignLanguage
    var body: some View {
        VStack(alignment: .leading) {
            Text("Zuerst wähle deine 3 LKs. LKs werden auf erhöhtem Niveau, mit 5 Wochenstunden, unterrichtet. Außerdem sind sie deine schriftlichen Prüfungsfächer.")
            
            VStack(alignment: .leading) {
                Picker("LK 1", selection: $performer1) {
                    Text("Deutsch").tag(CourseAttribute.german)
                    Text("Mathematik").tag(CourseAttribute.math)
                    Text("Fremdsprache").tag(CourseAttribute.foreignLanguage)
                    Text("Naturwissenschaft").tag(CourseAttribute.science)
                }
                Picker("LK 2", selection: $performer2) {
                    if performer1 != .german {
                        Text("Deutsch").tag(CourseAttribute.german)
                    }
                    if performer1 != .math {
                        Text("Mathematik").tag(CourseAttribute.math)
                    }
                    if performer1 != .foreignLanguage {
                        Text("Fremdsprache").tag(CourseAttribute.foreignLanguage)
                    }
                    if performer1 != .science {
                        Text("Naturwissenschaft").tag(CourseAttribute.science)
                    }
                }
                Picker("LK 3", selection: $performer3) {
                    if performer1 != .german && performer2 != .german {
                        Text("Deutsch").tag(CourseAttribute.german)
                    }
                    if performer1 != .math && performer2 != .math {
                        Text("Mathematik").tag(CourseAttribute.math)
                    }
                    if !((performer1 == .foreignLanguage && performer2 == .science) || (performer1 == .science && performer2 == .foreignLanguage)) {
                        Text("Fremdsprache").tag(CourseAttribute.foreignLanguage)
                        Text("KuMuTu").tag(CourseAttribute.artMusicSports)
                        Text("Naturwissenschaft").tag(CourseAttribute.science)
                    }
                    Text("Gesellschaftswissenschaft").tag(CourseAttribute.social)
                }
            }
            NavigationLink("Weiter zur Wahl der Grundkurse", destination: GradedBasicCourseSelectionView(availableCourses: availableCourses, performerCourseSelection: [performer1, performer2, performer3]))
                .onTapGesture {
                    courseSelection.performerCourses[0] = switch performer1 {
                        case .german:
                            availableCourses.first(where: { $0.attributes.contains(.german) })!
                        case .science:
                            availableCourses.first(where: { $0.attributes.contains(.science) })!
                        case .foreignLanguage:
                            availableCourses.first(where: { $0.attributes.contains(.foreignLanguage) })!
                        case .math:
                            availableCourses.first(where: { $0.attributes.contains(.math) })!
                        default: Course(name: "ERROR", lessonsPerWeek: [0, 0, 0, 0], attributes: [], field: .sports)
                            
                    }
                    courseSelection.performerCourses[1] = switch performer2 {
                        case .german:
                            availableCourses.first(where: { $0.attributes.contains(.german) })!
                        case .science:
                            availableCourses.first(where: { $0.attributes.contains(.science) })!
                        case .foreignLanguage:
                            availableCourses.first(where: { $0.attributes.contains(.foreignLanguage) })!
                        case .math:
                            availableCourses.first(where: { $0.attributes.contains(.math) })!
                        default: Course(name: "ERROR", lessonsPerWeek: [0, 0, 0, 0], attributes: [], field: .sports)
                            
                    }
                    courseSelection.performerCourses[2] = switch performer3 {
                        case .german:
                            availableCourses.first(where: { $0.attributes.contains(.german) })!
                        case .science:
                            availableCourses.first(where: { $0.attributes.contains(.science) })!
                        case .foreignLanguage:
                            availableCourses.first(where: { $0.attributes.contains(.foreignLanguage) })!
                        case .math:
                            availableCourses.first(where: { $0.attributes.contains(.math) })!
                        case .social:
                            availableCourses.first(where: { $0.attributes.contains(.socialStudies) })!
                        case .artMusicSports:
                            availableCourses.first(where: { $0.attributes.contains(.artMusicSports) })!
                        default: Course(name: "ERROR", lessonsPerWeek: [0, 0, 0, 0], attributes: [], field: .sports)
                            
                    }
                }
        }
        .navigationTitle("Wähle deine LKs")
    }
}

#Preview {
    let courses = try! JSONDecoder().decode([Course].self, from: try! Data(contentsOf: Bundle.main.url(forResource: "courses", withExtension: "json")!))
    PerformerCourseSelectionView(availableCourses: courses)
        .padding()
        .environment(CourseSelection(performerCourses: [], gradedBasicCourses: [], basicCourses: []))
}
