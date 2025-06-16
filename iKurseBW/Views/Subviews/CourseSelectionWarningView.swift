//
//  CourseSelectionWarningView.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 13.06.25.
//

import SwiftUI

struct CourseSelectionWarningView: View {
    let validity: CourseSelection.ValidityCheckResult
    var body: some View {
        switch validity {
        case .missingMandatoryCourses(let missing):
                if missing == [.sports] {
                    Label(.nurSportkursFehlt, systemImage: "exclamationmark.circle")
                        .foregroundStyle(.orange)
                    NavigationLink {
                        ResultView()
                    } label: {
                        HStack {
                            Text(.trotzdemWeiter)
#if os(macOS)
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundStyle(.secondary)
#endif
                        }
                    }
                } else {
                    Label(.fehlendeKurse, systemImage: "xmark.circle")
                        .foregroundStyle(.red)
                    ForEach(missing, id: \.self) { courseType in
                        Text(courseType.localized())
                    }
                }
        case .notEnoughCourses:
            Label(
                .nichtGenugKurse, systemImage: "xmark.circle"
            )
            .foregroundStyle(.red)
        case .dangerouslyLowAmountOfCourses:
            Label(
                .gefährlichWenigeKurse, systemImage: "exclamationmark.circle"
            )
            .foregroundStyle(.orange)
            NavigationLink {
                ResultView()
            } label: {
                HStack {
                    Text(.trotzdemWeiter)
#if os(macOS)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundStyle(.secondary)
#endif
                }
            }
        default:
            Label(
                .alleBenötigtenKurseAusgewählt,
                systemImage: "checkmark.circle"
            )
            .foregroundColor(.green)
            NavigationLink {
                ResultView()
            } label: {
                HStack {
                    Text(.weiter)
#if os(macOS)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundStyle(.secondary)
#endif
                }
            }
        }
    }
}

#Preview {
    List {
        CourseSelectionWarningView(validity: .valid)
        CourseSelectionWarningView(validity: .notEnoughCourses)
        CourseSelectionWarningView(validity: .dangerouslyLowAmountOfCourses)
        CourseSelectionWarningView(validity: .missingMandatoryCourses([.newScience, .artMusic]))
    }
        .environment(CourseSelection())
}
