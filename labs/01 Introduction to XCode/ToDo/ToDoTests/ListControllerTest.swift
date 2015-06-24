//
//  ListControllerTest.swift
//  ToDo
//
//  Created by Mark Tyers on 28/04/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit
import XCTest

class ListControllerTest: XCTestCase {
    
    var vc = ListController()

    override func setUp() {
        super.setUp()
        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        vc = storyboard.instantiateViewControllerWithIdentifier("ListVC") as! ListController
        vc.loadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        /// Extract the button.
//        let button:UIBarButtonItem button = UIBarButto
//        UIBarButtonItem *button = (UIBarButtonItem *)
//        [[presenter_ leftNavigationButtons] firstObject];
//        // Perform the action.
//        [[button target] performSelector:[button action]
//            withObject:button];
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
