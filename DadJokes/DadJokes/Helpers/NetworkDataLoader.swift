//
//  NetworkDataLoader.swift
//  DadJokes
//
//  Created by John Kouris on 1/2/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}
