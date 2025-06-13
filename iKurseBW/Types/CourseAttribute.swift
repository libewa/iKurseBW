//
//  CourseAttribute.swift
//  iKurseBW
//
//  Created by Linus Warnatz on 13.06.25.
//

import Foundation

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
            return String(localized: "Deutsch")
        case .science:
            return String(localized: "Naturwissenschaft")
        case .foreignLanguage:
            return String(localized: "Fremdsprache")
        case .math:
            return String(localized: "Mathematik")
        case .newScience:
            return String(localized: "Zweite Fremdsprache oder Naturwissenschaft")
        case .socialStudies:
            return String(localized: "Gemeinschaftskunde")
        case .geography:
            return String(localized: "Erdkunde")
        case .history:
            return String(localized: "Geschichte")
        case .religion:
            return String(localized: "Religion/Ethik")
        case .art:
            return String(localized: "Kunst")
        case .sports:
            return String(localized: "Sport")

        case .social:
            return String(localized: "Gesellschaftswissenschaften")
        case .artMusicSports:
            return String(localized: "Kunst, Musik oder Sport")
        case .artMusic:
            return String(localized: "Kunst oder Musik")

        case .noPerformerCourse:
            return String(localized: "Wahlpflichtfach")
        case .seminarCourse:
            return String(localized: "Seminarkurs")
        }
    }
}
