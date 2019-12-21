//
//  CoreDataStack.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_201 on 12/21/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Joke")
        
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistence stores: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext) throws {
        var error: Error?
        
        context.performAndWait {
            do {
                try context.save()
            }catch let saveError {
                error = saveError
            }
        }
        
        if let error = error { throw error }
    }
    
}
