//
//  ContentView.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 11.06.25.
//

import SwiftUI

struct ContentView: View {
    @State var selection = CourseSelection()
    var body: some View {
        NavigationStack {
            GreetingView()
        }
        .symbolRenderingMode(.hierarchical)
        .environment(selection)
    }
}

#Preview {
    ContentView()
        .environment(CourseSelection())
}
