//
//  Jokes.swift
//  DadJokes
//
//  Created by Enayatullah Naseri on 12/21/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation


struct Jokes: Codable {
    var id: UUID
    var question: String
    var answer: String
    var username: String
    
    init(id: UUID = UUID(), question: String, answer: String, username: String) {
        self.id = id
        self.question = question
        self.answer = answer
        self.username = username
    }
}
