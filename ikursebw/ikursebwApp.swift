//
//  ikursebwApp.swift
//  ikursebw
//
//  Created by Linus Warnatz on 15.02.25.
//

import SwiftUI

@main
struct ikursebwApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(CourseSelection(basicCourses: []))
        }
    }
}
