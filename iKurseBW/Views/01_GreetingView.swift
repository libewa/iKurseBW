//
//  GreetingView.swift
//  ikursebw
//
//  Created by Linus Warnatz on 15.02.25.
//

import SwiftUI
internal import UniformTypeIdentifiers

struct GreetingView: View {
    @Environment(CourseSelection.self) var courseSelection
    @State var fileImportPresented = false
    @State var showEasterEgg = false
    @State var error: Error? = nil
    @State var showError = false
    var body: some View {
        Form {
            Text(
                .willkommenText
            )
            Link(
                destination: URL(string: String("https://github.com/libewa/iKurseBW"))!
            ) {
                Label(.githubLink, systemImage: "network")
            }
            Link(
                destination: URL(
                    string:
                        String("https://km.baden-wuerttemberg.de/de/schule/gymnasium/abitur-und-oberstufe")
                )!
            ) {
                Label(
                    .kmInfoLink,
                    systemImage: "questionmark.circle"
                )
            }
            #if !os(tvOS)
                Text(.dateiAuswahlErklärung)

                HStack {
                    Button(
                        .dateiAuswählen,
                        systemImage: "arrow.down.document"
                    ) {
                        fileImportPresented = true
                    }
                    Spacer()
                    Text(
                        .kurseVerfügbar(courseSelection.availableCourses.count)
                    )
                }
#endif
            NavigationLink(
                .weiterZurLkWahl,
                destination: {
                    PerformerCourseSelectionView(
                        index: 0,
                        previousSelection: nil
                    )
                }
            )
        }
        .navigationTitle(.willkommenÜberschrift)
        #if !os(macOS)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "rainbow")
                    .symbolRenderingMode(.multicolor)
                    .onTapGesture {
                        withAnimation {
                            showEasterEgg.toggle()
                        }
                    }
                    .symbolEffect(.variableColor, isActive: showEasterEgg)
                }
            }
        #endif
        #if !os(tvOS)
            .fileImporter(
                isPresented: $fileImportPresented,
                allowedContentTypes: [.json]
            ) { result in
                do {
                    let file = try result.get()
                    let data = try Data(contentsOf: file)
                    let courses = try JSONDecoder().decode(
                        [Course].self,
                        from: data
                    )
                    courseSelection.availableCourses = courses
                } catch {
                    self.error = error
                }
            }
            .alert(
                .einFehlerIstAufgetreten,
                isPresented: $showError,
                presenting: error,
                actions: { _ in
                    Button(.ok, role: .cancel) {}
                },
                message: { error in
                    Text(error.localizedDescription)
                }
            )
        #endif
        #if !os(macOS) && !os(tvOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
        #if os(macOS)
            .padding()
        #endif
    }

}

#Preview {
    NavigationStack {
        GreetingView()
            .environment(CourseSelection())
    }
}
