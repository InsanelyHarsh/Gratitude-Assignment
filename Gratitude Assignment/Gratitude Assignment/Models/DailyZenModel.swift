//
//  DailyZenModel.swift
//  Gratitude Assignment
//
//  Created by Harsh Yadav on 13/10/23.
//

import Foundation

// MARK: - DailyZenModel
struct DailyZenModel: Codable {
    let text, author, uniqueID: String
//    let type:String
//    let dzType, language: String
//    let bgImageURL: String
    let theme, themeTitle: String
    let articleURL: String
    let dzImageURL: String
    let primaryCTAText, sharePrefix: String

    enum CodingKeys: String, CodingKey {
        case text, author
        case uniqueID = "uniqueId"
//        case type, dzType, language
//        case bgImageURL = "bgImageUrl"
        case theme, themeTitle
        case articleURL = "articleUrl"
        case dzImageURL = "dzImageUrl"
        case primaryCTAText, sharePrefix
    }
}

