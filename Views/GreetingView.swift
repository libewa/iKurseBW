//
//  GreetingView.swift
//  ikursebw
//
//  Created by Linus Warnatz on 15.02.25.
//

import SwiftUI
import FilePicker

struct GreetingView: View {
    @State var availableCourses: [Course] = try! JSONDecoder().decode([Course].self, from: try! Data(contentsOf: Bundle.main.url(forResource: "courses", withExtension: "json")!))
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hallo, und willkommen bei iKurseBW!")
            Text("Diese App hilft dir bei der Wahl deiner Kurse für die Kursstufe des allgemeinbildenden Gymnasiums (Klasse 11 und 12 oder 12 und 13).")
            Text("Bitte wähle eine Datei mit verfügbaren Kursen, oder benutze die Standardauswahl.")
            FilePicker(types: [.json], allowMultiple: false, title: "Wähle eine Datei", onPicked: { urls in
                if let url = urls.first {
                    do {
                        availableCourses = try JSONDecoder().decode([Course].self, from: try Data(contentsOf: url))
                    } catch {
                        print("Error decoding courses: \(error)")
                    }
                }
            })
            Text("Zuerst wählen wir deine Leistunskurse (LKs).")
            NavigationLink("Weiter zur LK-Wahl", destination: PerformerCourseSelectionView(availableCourses: availableCourses))
        }
        .navigationTitle("Willkommen bei iKurseBW!")
    }
        
}

#Preview {
    GreetingView()
        .padding()
}
