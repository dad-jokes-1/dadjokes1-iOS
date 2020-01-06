//
//  URLSession+NetworkDataLoader.swift
//  DadJokes
//
//  Created by John Kouris on 1/2/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import Foundation

extension URLSession: NetworkDataLoader {
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = self.dataTask(with: request) { data, _, error in
            completion(data, error)
        }
        task.resume()
    }
}
