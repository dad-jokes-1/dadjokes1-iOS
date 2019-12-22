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
//import JWTDecode

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class APIController {
    private let baseURL = URL(string: "https://dadjokes-3fe30.firebaseio.com/.json")!
    
    struct HTTPMethod {
        static let get = "GET"
        static let put = "PUT"
        static let post = "POST"
        static let delete = "DELETE"
    }
    
    func signUp (username: String, email: String, password: String, completion: @escaping (Error?) -> Void = {_ in})  {
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
        let joke = Joke(id: id, question: question, answer: answer, username: username)
        post(joke: joke)
        // TODO: add saving to CD
        return joke
    }
    
    
    func fetchJokes() {
        
    }
    
    
    func updateJokes(){
        
    }
    
    
    func deleteJoke(){
        
    }
    
}
