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
    
    @discardableResult convenience init(id: UUID,
                                        question: String,
                                        answer: String,
                                        username: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.id = id
        self.question = question
        self.answer = answer
        self.username = username
    }
    
    @discardableResult convenience init?(jokeRepresentation: JokeRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
    }
    
    var jokeRepresentation: JokeRepresentation? {
        return JokeRepresentation(id: id?.uuidString ?? "", question: question ?? "", answer: answer ?? "", username: username ?? "")
    }
}


