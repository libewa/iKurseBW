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
            Text("""
            Hallo, und willkommen bei iKurseBW!
            Diese App hilft dir bei der Wahl deiner Kurse für die Kursstufe des allgemeinbildenden Gymnasiums (Klasse 11 und 12 oder 12 und 13).
            
            Die App ist noch in der Entwicklung, daher kann es zu Fehlern kommen. Bitte melde diese über GitHub oder per E-Mail.
            Bitte beachte, dass die App keine offizielle App des Kultusministeriums ist und daher keine Garantie für die Richtigkeit der Informationen gegeben werden kann.
            """)
            Link(destination: URL(string: "https://github.com/libewa/iKurseBW")!) {
                Label("App-Quellcode auf GitHub", systemImage: "network")
            }
            Link(destination: URL(string: "https://km.baden-wuerttemberg.de/de/schule/gymnasium/abitur-und-oberstufe")!) {
                Label("Offizielle Informationen des Kultusministeriums", systemImage: "questionmark.circle")
            }
            Text("Bitte wähle eine Datei mit verfügbaren Kursen, oder benutze die Standardauswahl.")
            
            HStack {
                Button("Datei auswählen", systemImage: "arrow.down.document") {
                    fileImportPresented = true
                }
                Spacer()
                Text("\(courseSelection.availableCourses.count) Kurse verfügbar")
            }
            NavigationLink("Weiter zur LK-Wahl", destination: PerformerCourseSelectionView(index: 0, previousSelection: nil))
        }
        .navigationTitle("Willkommen bei iKurseBW!")
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
        .fileImporter(isPresented: $fileImportPresented, allowedContentTypes: [.json]) { result in
            do {
                let file = try result.get()
                let data = try Data(contentsOf: file)
                let courses = try JSONDecoder().decode([Course].self, from: data)
                courseSelection.availableCourses = courses
            } catch {
                self.error = error
            }
        }
        .alert("Ein Fehler ist aufgetreten", isPresented: $showError, presenting: error, actions: { _ in
            Button("OK", role: .cancel) { }
        }, message: { error in
            Text(error.localizedDescription)
        })
        .navigationBarTitleDisplayMode(.inline)
    }
        
}

#Preview {
    NavigationStack {
        GreetingView()
            .environment(CourseSelection())
    }
}
