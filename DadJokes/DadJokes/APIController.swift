//
//  APIController.swift
//  DadJokes
//
//  Created by Enayatullah Naseri on 12/21/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

struct HTTPMethod {
    static let get = "GET"
    static let put = "PUT"
    static let post = "POST"
    static let delete = "DELETE"
}

class APIController {
    private let baseURL = URL(string: "https://dadjokes-3fe30.firebaseio.com/.json")!
    
    init() {
        fetchJokesFromServer()
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Error?) -> Void = {_ in})  {
        let signUpURL = baseURL.appendingPathComponent("register")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post // raw value
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.addValue("USER_TOKEN", forHTTPHeaderField: "Authorization")
        
        let userParams = ["username": username, "email": email, "password": password] as [String: Any]
        do {
            let json = try JSONSerialization.data(withJSONObject: userParams, options: .prettyPrinted)
            request.httpBody = json
        } catch {
            NSLog("Error encoding JSON")
            return
        }
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                
                completion(NSError(domain:"", code: response.statusCode, userInfo: nil))
                return
            }
            if let error = error {
                completion(error)
                return
            }
            NSLog("Successfully signed up User")
            //                    self.signIn(email: email, password: password, completion: completion)
            
            completion(nil)
        } .resume()
    }
    
    func signIn() {
        
    }
    
    func post(joke: Joke, completion: @escaping () -> Void = {}) {
        let encoder = JSONEncoder()
        
        var request = URLRequest(url: baseURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.post
        
        guard let jokeRepresentation = joke.jokeRepresentation else {
            print("Joke representation is nil")
            completion()
            return
        }
        
        do {
            request.httpBody = try encoder.encode(jokeRepresentation)
        } catch {
            print("Error encoding joke")
            completion()
            return
        }
        
        AF.request(request).response { (response) in
            switch response.result {
            case .success:
                print("Success")
            case .failure:
                print("Failed")
            }
        }
    }
    
    @discardableResult func createJoke(id: UUID = UUID(), question: String, answer: String, username: String) -> Joke {
        let joke = Joke(id: id, question: question, answer: answer, username: username, context: CoreDataStack.shared.mainContext)
        post(joke: joke)
        CoreDataStack.shared.save()
        return joke
    }
    
    func fetchJokesFromServer(completion: @escaping (Error?) -> Void = { _ in }) {
        var request = URLRequest(url: baseURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.get
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(error)
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jokeRepresentations = try decoder.decode([String: JokeRepresentation].self, from: data).map({ $0.value })
                self.updateJokes(with: jokeRepresentations)
            } catch {
                completion(error)
                return
            }
        }.resume()
    }
    
    func updateJokes(with representations: [JokeRepresentation]) {
        let identifiersToFetch = representations.compactMap({ UUID(uuidString: $0.id) })
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        
        var jokesToCreate = representationsByID
        
        let context = CoreDataStack.shared.mainContext
        context.performAndWait {
            do {
                let fetchRequest: NSFetchRequest<Joke> = Joke.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id IN %@", identifiersToFetch)
                
                let existingJokes = try context.fetch(fetchRequest)
                
                for joke in existingJokes {
                    guard let id = joke.id,
                        let representation = representationsByID[id] else { continue }
                    
                    joke.answer = representation.answer
                    joke.question = representation.question
                    joke.username = representation.username
                    
                    jokesToCreate.removeValue(forKey: id)
                }
                
                for representation in jokesToCreate.values {
                    Joke(jokeRepresentation: representation, context: context)
                }
                
                CoreDataStack.shared.save(context: context)
            } catch {
                print("Error fetching jokes from persistent store: \(error)")
            }
        }
    }
    
    func deleteJoke(){
        
    }
    
}
