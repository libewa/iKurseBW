import SwiftUI

enum CourseGradingType {
    case performer, basic, gradedBasic, none
}

struct CourseTableLine: View {
    @Environment(CourseSelection.self) var courseSelection
    let course: Course
    @State var selected = CourseGradingType.none
    let locked: Bool
    var body: some View {
        HStack {
            Text(course.name)
            Spacer()
            if selected == .performer {
                Button {
                } label: {
                    Label("Leistungsfach", systemImage: "graduationcap.fill")
                        .tag(CourseGradingType.performer).labelStyle(.iconOnly)
                }.disabled(true)
            } else if selected == .gradedBasic {
                Button {
                } label: {
                    Label(
                        "Basisfach mündlich geprüft",
                        systemImage: "inset.filled.rectangle.and.person.filled"
                    ).tag(CourseGradingType.gradedBasic).labelStyle(.iconOnly)
                }.disabled(true)
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
                        if selected == .basic {
                            Label("Basisfach", systemImage: "book.closed.fill")
                                .tag(CourseGradingType.basic).labelStyle(
                                    .iconOnly
                                )
                        } else {
                            Label("Nicht gewählt", systemImage: "slash.circle")
                                .tag(CourseGradingType.none).labelStyle(
                                    .iconOnly
                                )
                        }
                    }
                }
                .buttonStyle(.bordered)
                .disabled(
                    (!courseSelection.allSelectedCourses.filter {
                        $0.attributes.contains(course.attributes[0]) && !$0.attributes.contains(.inDepthCourse)
                    }.isEmpty && course.mustBeUnique && selected == .none)
                        || locked
                )
            }
            if courseSelection.performerCourses.contains(where: {
                $0?.name == course.name
            }) {
                Text(
                    "5 5 5 5",
                    comment:
                        "The number of lessons per week for performer courses"
                )
                .font(.system(size: 12, weight: .bold, design: .monospaced))
            } else {
                Text(
                    verbatim:
                        "\(course.lessonsPerWeek[0]) \(course.lessonsPerWeek[1]) \(course.lessonsPerWeek[2]) \(course.lessonsPerWeek[3])"
                )
                .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
        }
        .onAppear {
            if courseSelection.performerCourses.contains(where: {
                $0?.name == course.name
            }) {
                selected = .performer
            } else if courseSelection.gradedBasicCourses.contains(where: {
                $0?.name == course.name
            }) {
                selected = .gradedBasic
            } else if courseSelection.basicCourses.contains(where: {
                $0.name == course.name
            }) {
                selected = .basic
            }
        }
        .onChange(of: selected) {
            withAnimation {
                if selected == .basic {
                    if !courseSelection.basicCourses.contains(course) {
                        courseSelection.basicCourses.append(course)
                    }
                } else {
                    courseSelection.basicCourses.removeAll(where: {
                        $0.name == course.name
                    })
                }
            }
        }
        .disabled(locked)
    }
}

#Preview {
    CourseTableLine(
        course: Course(
            name: "Mathematik",
            lessonsPerWeek: [3, 3, 3, 3],
            attributes: [.math],
            field: .science
        ),
        selected: .performer,
        locked: false
    )
    .environment(CourseSelection())
}
