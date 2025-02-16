//
//  ikursebwTests.swift
//  ikursebwTests
//
//  Created by Linus Warnatz on 15.02.25.
//

import Testing
import Foundation

struct ikursebwTests {

    @Test func testSingleCourseDecoding() async throws {
        let courseJson = """
            {
                "name": "Deutsch",
                "lessonsPerWeek": [4, 4, 4, 4],
                "attributes": ["german"]
            }
        """.data(using: .utf8)!
        let course = try JSONDecoder().decode(Course.self, from: courseJson)
        #expect(course.name == "Deutsch")
        #expect(course.lessonsPerWeek == [4, 4, 4, 4])
        #expect(course.attributes == [CourseAttribute.german])
    }
    @Test func testCourseArrayDecoding() async throws {
        guard let fileURL = Bundle.main.url(forResource: "courses", withExtension: "json") else {
            Issue.record("courses.json not found")
            return
        }
        
        let data = try Data(contentsOf: fileURL)
        let courses = try JSONDecoder().decode([Course].self, from: data)
        #expect(courses.count == 29)
    }
}
