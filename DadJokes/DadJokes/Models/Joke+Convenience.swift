//
//  Joke+Convenience.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_201 on 12/21/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation
import CoreData

extension Joke {
    
    var jokeRepresentation: JokeRepresentation? {
        guard let question = question,
            let identifier = identifier?.uuidString,
            let answer = answer,
            let username = username else { return nil }
        return JokeRepresentation(identifier: identifier, question: question, answer: answer, username: username)
    }
    
    convenience init(identifier: UUID = UUID(),
                     question: String,
                     answer: String,
                     username: String,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.identifier = identifier
        self.question = question
        self.answer = answer
        self.username = username
    }
    
    @discardableResult convenience init?(jokeRepresentation: JokeRepresentation, context: NSManagedObjectContext) {
        guard let identifier = UUID(uuidString: jokeRepresentation.identifier) else { return nil }
        self.init(identifier: identifier, question: jokeRepresentation.question, answer: jokeRepresentation.answer, username: jokeRepresentation.username, context: context)
    }
    
}


