//
//  DadJokesUITests.swift
//  DadJokesUITests
//
//  Created by John Kouris on 12/26/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import XCTest

class DadJokesUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    func testSignUpAndSignInButtonsAppearOnHomeScreen() {
        XCTAssertTrue(app.buttons["Sign In"].exists)
        XCTAssertTrue(app.buttons["Sign Up"].exists)
    }
    
    func testTabsExistInTabBar() {
        let tabBarsQuery = XCUIApplication().tabBars
        XCTAssertTrue(tabBarsQuery.buttons["Public"].exists)
        XCTAssertTrue(tabBarsQuery.buttons["Private"].exists)
    }
    
    func testSignUpDisplaysProperFields() {
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        
        XCTAssertTrue(app.textFields["first name"].exists)
        XCTAssertTrue(app.textFields["last name"].exists)
        XCTAssertTrue(app.textFields["username"].exists)
        XCTAssertTrue(app.textFields["email"].exists)
        XCTAssertTrue(app.secureTextFields["password"].exists)
    }
    
    func testEmailAndPasswordTextFieldsAppearInSignIn() {
        let signInButton = app.buttons["Sign In"]
        signInButton.tap()
        
        XCTAssertTrue(app.textFields["email"].exists)
        XCTAssertTrue(app.secureTextFields["password"].exists)
    }
    
    func testBlankSignInShowsAlert() {
        let signInButton = app.buttons["Sign In"]
        signInButton.tap()
        app.textFields["email"].tap()
        app.secureTextFields["password"].tap()
        signInButton.tap()
        
        XCTAssertTrue(app.alerts["Error!"].exists)
    }
}
