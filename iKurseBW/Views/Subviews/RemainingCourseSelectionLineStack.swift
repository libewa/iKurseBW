import SwiftUI

enum CourseGradingType {
    case performer, basic, gradedBasic, none
}

struct RemainingCourseSelectionLineStack: View {
    @Environment(CourseSelection.self) var courseSelection
    let course: Course
    @State var selected = CourseGradingType.none
    var body: some View {
        HStack {
            Text(course.name)
            if selected == .performer {
                Spacer()
                Label("Leistungsfach", systemImage: "graduationcap.fill").tag(CourseGradingType.performer).labelStyle(.iconOnly)
            } else if selected == .gradedBasic {
                Spacer()
                Label("Basisfach mündlich geprüft", systemImage: "inset.filled.rectangle.and.person.filled").tag(CourseGradingType.gradedBasic).labelStyle(.iconOnly)
            } else {
                Button {
                    withAnimation {
                        if selected == .basic {
                            selected = .none
                        } else {
                            selected = .basic
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if selected == .basic {
                            Label("Basisfach", systemImage: "book.closed.fill").tag(CourseGradingType.basic).labelStyle(.iconOnly)
                        } else {
                            Label("Nicht gewählt", systemImage: "slash.circle").tag(CourseGradingType.none).labelStyle(.iconOnly)
                        }
                    }
                }
                .disabled(
                    courseSelection.availableCourses.filter { $0.attributes.contains(course.attributes[0]) }.count == 1
                )
            }
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

#Preview {
    RemainingCourseSelectionLineStack(course: Course(name: "Mathematik", lessonsPerWeek: [3,3,3,3], attributes: [.math], field: .science), selected: .none)
        .environment(CourseSelection())
}
