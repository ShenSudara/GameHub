//
//  QuizRushQuestionResponseModel.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-05.
//

import Foundation

// quiz rush API response model
struct QuizRushQuestionResponseModel: Codable {
    let responseCode: Int
    let results: [QuizRushQuestionModel]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}
