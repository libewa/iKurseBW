//
//  GreetingView.swift
//  ikursebw
//
//  Created by Linus Warnatz on 15.02.25.
//

import SwiftUI

struct GreetingView: View {
    let availableCourses: [Course] = try! JSONDecoder().decode([Course].self, from: try! Data(contentsOf: Bundle.main.url(forResource: "courses", withExtension: "json")!))
    var body: some View {
        VStack(alignment: .leading) {
            Text("""
            Hallo, und willkommen bei iKurseBW!
            Diese App hilft dir bei der Wahl deiner Kurse für die Kursstufe des allgemeinbildenden Gymnasiums (Klasse 11 und 12 oder 12 und 13).
            
            Die App ist noch in der Entwicklung, daher kann es zu Fehlern kommen. Bitte melde diese über GitHub oder per E-Mail.
            Bitte beachte, dass die App keine offizielle App des Kultusministeriums ist und daher keine Garantie für die Richtigkeit der Informationen gegeben werden kann.
            """)
            Link("App-Quellcode auf GitHub", destination: URL(string: "https://github.com/libewa/iKurseBW")!)
            Link("Offizielle Informationen des Kultusministeriums", destination: URL(string: "https://km.baden-wuerttemberg.de/de/schule/gymnasium/abitur-und-oberstufe")!)
            /* Text("Bitte wähle eine Datei mit verfügbaren Kursen, oder benutze die Standardauswahl.") */
            //TODO: Implement file selection for courses
            Text("Zuerst wählen wir deine drei Leistungskurse (LKs).")
            NavigationLink("Weiter zur LK-Wahl", destination: PerformerCourseSelectionView(index: 0))
        }
        .padding()
        .navigationTitle("Willkommen bei iKurseBW!")
    }
        
}

#Preview {
    GreetingView()
}
