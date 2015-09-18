//
//  NoteTest.swift
//  Note Well
//
//  Created by Mark Tyers on 26/04/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit
import XCTest

class NoteTest: XCTestCase {

    func testCreateNote() {
        var date = NSDate()
        var note = Note(title: "Note 1", content: "Lorem ipsum")
        XCTAssertNotNil(note)
        XCTAssertEqual(note.noteTitle, "Note 1")
        XCTAssertEqual(note.noteContent, "Lorem ipsum")
        // property returns a UNIX timestamp with floating point component for fractions of a second
        XCTAssertEqualWithAccuracy(note.noteAdded.timeIntervalSinceReferenceDate, date.timeIntervalSinceReferenceDate, 0.00001)
    }
    
    func testUpdateNote() {
        var note = Note(title: "Note 1", content: "Lorem ipsum")
        note.noteTitle = "New Title"
        note.noteContent = "Dolor sit amet"
        XCTAssertEqual(note.noteTitle, "New Title")
        XCTAssertEqual(note.noteContent, "Dolor sit amet")
    }

}
