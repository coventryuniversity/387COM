//
//  ToDo_UI_Tests.swift
//  ToDo UI Tests
//
//  Created by Mark Tyers on 26/06/2015.
//  Copyright © 2015 Coventry University. All rights reserved.
//

import Foundation
import XCTest

class ToDo_UI_Tests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // stop immediately when a failure occurs.
        continueAfterFailure = false
        // launch the application.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.navigationBars["TODO"].buttons["Add"].tap()
        let alert = app.alerts["New Item"]
        let itemNameTextField = alert.collectionViews.textFields["Item name"]
        itemNameTextField.typeText("cheese")
        alert.collectionViews.buttons["OK"].tap()
        let table = XCUIApplication().tables
        table.staticTexts["Bread"].tap()
        
    }
    
}
