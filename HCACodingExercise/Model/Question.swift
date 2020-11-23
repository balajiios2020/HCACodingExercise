//
//  Question.swift
//  HCACodingExercise
//
//  Created by Balaji Peddaiahgari on 11/22/20.
//  Copyright © 2020 Balaji Peddaiahgari. All rights reserved.
//

import Foundation

struct Question: Decodable {
    let title: String
    let isAnswered: Bool
    let answerCount: Int

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case isAnswered = "is_answered"
        case answerCount = "answer_count"
    }
}
