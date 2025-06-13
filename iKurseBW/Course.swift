//
//  Course.swift
//  ikursebw
//
//  Created by Linus Warnatz on 16.02.25.
//

import SwiftUI

enum CourseAttribute: String, Codable {
    case german
    case science
    case foreignLanguage
    case math
    case newScience
    case socialStudies
    case geography
    case history
    case religion
    case art
    case sports

    case social
    case artMusicSports
    case artMusic

    case noPerformerCourse
    case seminarCourse
    
    func localized() -> String {
        switch self {
        case .german:
            return "Deutsch"
        case .science:
            return "Naturwissenschaft"
        case .foreignLanguage:
            return "Fremdsprache"
        case .math:
            return "Mathematik"
        case .newScience:
            return "Zweite Fremdsprache oder Naturwissenschaft"
        case .socialStudies:
            return "Gemeinschaftskunde"
        case .geography:
            return "Erdkunde"
        case .history:
            return "Geschichte"
        case .religion:
            return "Religion"
        case .art:
            return "Kunst"
        case .sports:
            return "Sport"

        case .social:
            return "Gesellschaftswissenschaften"
        case .artMusicSports:
            return "Kunst, Musik oder Sport"
        case .artMusic:
            return "Kunst oder Musik"

        case .noPerformerCourse:
            return "Wahlpflichtfach"
        case .seminarCourse:
            return "Seminarkurs"
        }
    }
}
enum Field: Int, Codable {
    case language = 1
    case social = 2
    case science = 3
    case sports = 4
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
    
    private var oralGradingAvailable: Bool {
        for e in lessonsPerWeek {
            if e < 1 {
                return false
            }
        }
        return true
    }

    func isValidPerformerCourse(performers: [Course?]) -> Bool {
        if (performers[0] != nil && performers[1] != nil && performers[2] == nil) && !performers.contains(where: { $0?.attributes.contains(where: { $0 == .german || $0 == .math }) ?? false})  {
            // Third performer must be German, Math or Social
            if !(self.attributes.contains(.german) || self.attributes.contains(.math) || self.attributes.contains(.social)) {
                return false
            }
        }
        return !self.attributes.contains(.noPerformerCourse) && !performers.contains(self)
    }
    func isAvailableForOralGrading(performers: [Course?]) -> Bool {
        if !oralGradingAvailable {
            return false
        }
        if performers.contains(self) {
            return false
        }
        return true
    }
}
