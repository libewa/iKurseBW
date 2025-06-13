import SwiftUI

enum CourseSelection {
    case performer, basic, gradedBasic, none
}

struct FullCourseSelectionLineStack: View {
    @Environment(CourseSelection.self) var courseSelection
    let course: Course
    @State var selected = CourseSelection.none
    var body: some View {
        HStack {
            Text(course.name)
            Spacer()
            Picker("", selection: $selected) {
                Label("Leistungsfach", systemImage: "graduationcap.fill").tag(CourseSelection.performer).labelStyle(.iconOnly)
                Label("Basisfach", systemImage: "book.closed.fill").tag(CourseSelection.basic).labelStyle(.iconOnly)
                Label("Basisfach mündlich geprüft", systemImage: "inset.filled.rectangle.and.person.filled").tag(CourseSelection.gradedBasic).labelStyle(.iconOnly)
                Label("Nicht gewählt", systemImage: "slash.circle.fill").tag(CourseSelection.none).labelStyle(.iconOnly)
            }
            .pickerStyle(.segmented)
            .disabled(
                selected == .performer || selected == .gradedBasic
            )

            Spacer()
            Text("\(course.lessonsPerWeek[0]) \(course.lessonsPerWeek[1]) \(course.lessonsPerWeek[2]) \(course.lessonsPerWeek[3])")
                .font(.system(size: 12, weight: .bold, design: .monospaced))
        }
        .onAppear {
            if courseSelection.performerCourses.contains(where: { $0?.name == course.name }) {
                selected = .performer
            } else if courseSelection.gradedBasicCourses.contains(where: { $0?.name == course.name }) {
                selected = .gradedBasic
            }
        }
        .onChange(of: selected) {
            withAnimation {
                if selected == .basic {
                    if !courseSelection.basicCourses.contains(course) {
                        courseSelection.basicCourses.append(course)
                    }
                } else {
                    courseSelection.basicCourses.removeAll(where: { $0.name == course.name })
                }
            }
        }
    }
}