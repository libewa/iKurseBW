//
//  GreetingView.swift
//  ikursebw
//
//  Created by Linus Warnatz on 15.02.25.
//

import SwiftUI
//import FilePicker

struct GreetingView: View {
    let availableCourses: [Course] = try! JSONDecoder().decode([Course].self, from: try! Data(contentsOf: Bundle.main.url(forResource: "courses", withExtension: "json")!))
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hallo, und willkommen bei iKurseBW!")
            Text("Diese App hilft dir bei der Wahl deiner Kurse für die Kursstufe des allgemeinbildenden Gymnasiums (Klasse 11 und 12 oder 12 und 13).")
            /* Text("Bitte wähle eine Datei mit verfügbaren Kursen, oder benutze die Standardauswahl.")
             FilePicker() */
            Text("Zuerst wählen wir deine Leistungskurse (LKs).")
            NavigationLink("Weiter zur LK-Wahl", destination: PerformerCourseSelectionView(index: 0))
        }
        .navigationTitle("Willkommen bei iKurseBW!")
    }
        
}

#Preview {
    GreetingView()
        .padding()
}
