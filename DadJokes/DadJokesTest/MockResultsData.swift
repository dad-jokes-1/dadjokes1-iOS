//
//  MockResultsData.swift
//  DadJokesTest
//
//  Created by John Kouris on 1/2/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import Foundation

let goodResultsData = """
{
  "78CDF95C-7587-4B1A-823F-71F89261E2D5": {
    "answer": "Test",
    "identifier": "78CDF95C-7587-4B1A-823F-71F89261E2D5",
    "question": "Test",
    "username": ""
  },
  "7F631B51-A4CF-49A1-AACF-09288BDA3CAF": {
    "answer": "A tractor",
    "identifier": "7F631B51-A4CF-49A1-AACF-09288BDA3CAF",
    "question": "How do you get a country girl’s attention?",
    "username": ""
  }
}
""".data(using: .utf8)!

let badResultsData = """
{
  "78CDF95C-7587-4B1A-823F-71F89261E2D5": {
    "answer": "Test",
    "identifier": "78CDF95C-7587-4B1A-823F-71F89261E2D5",
    "question": "Test",
    "username": ""
  },
  "7F631B51-A4CF-49A1-AACF-09288BDA3CAF": {
    "answer": "A tractor",
    "identifier": "7F631B51-A4CF-49A1-AACF-09288BDA3CAF",
    "question": "How do you get a country girl’s attention?",
    "username": ""
  }
""".data(using: .utf8)!

let noResultsData = """
{}
""".data(using: .utf8)!
