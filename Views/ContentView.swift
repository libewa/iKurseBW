//
//  ContentView.swift
//  ikursebw
//
//  Created by Linus Warnatz on 15.02.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GreetingView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(CourseSelection(performerCourses: [], gradedBasicCourses: [], basicCourses: []))
}
