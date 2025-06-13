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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "rainbow")
                        .symbolRenderingMode(.multicolor)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(CourseSelection())
}
