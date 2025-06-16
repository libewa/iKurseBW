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
    case inDepthCourse

    func localized() -> String {
        switch self {
            case .german:
                return String(localized: .deutsch)
            case .science:
                return String(localized: .naturwissenschaft)
            case .foreignLanguage:
                return String(localized: .fremdsprache)
            case .math:
                return String(localized: .mathematik)
            case .newScience:
                return String(
                    localized: .zweiteFremdspracheOderNaturwissenschaft
                )
            case .socialStudies:
                return String(localized: .gemeinschaftskunde)
            case .geography:
                return String(localized: .erdkunde)
            case .history:
                return String(localized: .geschichte)
            case .religion:
                return String(localized: .religionEthik)
            case .art:
                return String(localized: .kunst)
            case .sports:
                return String(localized: .sport)
                
            case .social:
                return String(localized: .gesellschaftswissenschaften)
            case .artMusicSports:
                return String(localized: .kunstMusikOderSport)
            case .artMusic:
                return String(localized: .kunstOderMusik)
                
            case .noPerformerCourse:
                return String(localized: .wahlpflichtfach)
            case .seminarCourse:
                return String(localized: .seminarkurs)
            case .inDepthCourse:
                return String(localized: .vertiefungskurs)
        }
    }
}
