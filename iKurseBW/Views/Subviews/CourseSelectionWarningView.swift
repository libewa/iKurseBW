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
            Label("Fehlende Kurse", systemImage: "xmark.circle")
                .foregroundStyle(.red)
            ForEach(missing, id: \.self) { courseType in
                Text(courseType.localized())
            }
        case .notEnoughCourses:
            Label(
                "Du brauchst mindestens 42 Kurse (Semester eines Faches)", systemImage: "xmark.circle"
            )
            .foregroundStyle(.red)
        case .dangerouslyLowAmountOfCourses:
            Label(
                "Es werden mindestens 44 Kurse empfohlen. Mit 42 Kursen besteht das Risiko, bei einer Sportverletzung oder längerer Krankheit nicht zum Abitur zugelassen zu werden.", systemImage: "exclamationmark.circle"
            )
            .foregroundStyle(.orange)
            NavigationLink {
                ResultView()
            } label: {
                HStack {
                    Text("Trotzdem weiter")
#if os(macOS)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundStyle(.secondary)
#endif
                }
            }
        default:
            Label(
                "Alle benötigten Kurse ausgewählt!",
                systemImage: "checkmark.circle"
            )
            .foregroundColor(.green)
            NavigationLink {
                ResultView()
            } label: {
                HStack {
                    Text("Weiter")
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
