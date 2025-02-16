//
//  Course.swift
//  ikursebw
//
//  Created by Linus Warnatz on 16.02.25.
//

enum CourseAttribute: String, Codable {
    case german, science, foreignLanguage, math, newScience, socialStudies, geography, history, religion, art, sports
    case social, artMusicSports
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
    static func == (lhs: Course, rhs: Course) -> Bool {
        if lhs.name != rhs.name {
            return false
        }
        if lhs.lessonsPerWeek != rhs.lessonsPerWeek {
            return false
        }
        if lhs.attributes != rhs.attributes {
            return false
        }
        if lhs.field != rhs.field {
            return false
        }
        return true
    }
    
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        lessonsPerWeek = Array(try values.decode([Int].self, forKey: .lessonsPerWeek)[0...3])
        attributes = try values.decode([CourseAttribute].self, forKey: .attributes)
        field = try values.decode(Field.self, forKey: .field)
    }
    init(name: String, lessonsPerWeek: [Int], attributes: [CourseAttribute], field: Field) {
        self.name = name
        self.lessonsPerWeek = lessonsPerWeek
        self.attributes = attributes
        self.field = field
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(lessonsPerWeek, forKey: .lessonsPerWeek)
        try container.encode(attributes, forKey: .attributes)
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
