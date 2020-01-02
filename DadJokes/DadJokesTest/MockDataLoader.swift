//
//  MockDataLoader.swift
//  DadJokesTest
//
//  Created by John Kouris on 1/2/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import Foundation
@testable import DadJokes

class MockDataLoader: NetworkDataLoader {
    var request: URLRequest?
    var data: Data?
    var error: Error?
    
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.request = request
        DispatchQueue.main.async {
            completion(self.data, self.error)
        }
    }
    
}
