//
//  Course.swift
//  ikursebw
//
//  Created by Linus Warnatz on 16.02.25.
//

enum CourseAttribute: String, Codable {
    case german, science, foreignLanguage, math, newScience, socialStudies, geography, history, religion, art, sports
    case social, artMusicSports, artMusic
    case noPerformerCourse, seminarCourse
}
enum Field: Int, Codable {
    case language = 1
    case social = 2
    case science = 3
    case sports = 4
    case elective = 5
}

/// Represents a single course, with its name, lessons per week for each semester, and attributes.
struct Course: Codable, Equatable, Hashable, Identifiable {
    var name: String
    var id: String { name }
    var lessonsPerWeek: [Int]
    var attributes: [CourseAttribute]
    var field: Field
    
    enum CodingKeys: String, CodingKey {
        case name
        case lessonsPerWeek
        case attributes
        case field
    }
    
    func oralGradingAvailable() -> Bool {
        for e in lessonsPerWeek {
            if e < 1 {
                return false
            }
        }
        return true
    }
}
