//
//  DadJokesTest.swift
//  DadJokesTest
//
//  Created by John Kouris on 1/2/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import XCTest
@testable import DadJokes

class DadJokesTest: XCTestCase {

    func testForSomeResultsGettingReturned() {
        let mock = MockDataLoader()
        mock.data = goodResultsData
        
        let controller = APIController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for results")
        
        controller.fetchJokesFromServer { (error) in
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 5)
        
        XCTAssertTrue(controller.searchResults.count == 2, "Expecting 2 results from fetch")
    }
    
    func testBadResultData() {
        let mock = MockDataLoader()
        mock.data = badResultsData
        
        let controller = APIController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for results")
        
        controller.fetchJokesFromServer { (error) in
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 5)
        
        XCTAssertTrue(controller.searchResults.isEmpty, "Expecting no results for bad data")
        XCTAssertNotNil(controller.error)
    }
    
    func testNoResults() {
        let mock = MockDataLoader()
        mock.data = noResultsData
        
        let controller = APIController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for results")
        
        controller.fetchJokesFromServer { (error) in
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 5)
        
        XCTAssertTrue(controller.searchResults.isEmpty, "Expecting no results for bad data")
        XCTAssertNil(controller.error)
    }

}
