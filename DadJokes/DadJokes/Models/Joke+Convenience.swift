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
    
    convenience init(id: UUID = UUID(),
                     question: String,
                     answer: String,
                     username: String,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = id
        self.question = question
        self.answer = answer
        self.username = username
    }
    
    @discardableResult convenience init?(jokeRepresentation: JokeRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let id = UUID(uuidString: jokeRepresentation.id) else { return nil }
        self.init(id: id, question: jokeRepresentation.question, answer: jokeRepresentation.answer, username: jokeRepresentation.username, context: context)
    }
    
    var jokeRepresentation: JokeRepresentation? {
        return JokeRepresentation(id: id?.uuidString ?? "", question: question ?? "", answer: answer ?? "", username: username ?? "")
    }
}


