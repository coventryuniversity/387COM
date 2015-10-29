//
//  NotesTests.swift
//  NotesTests
//
//  Created by Mark Tyers on 29/10/2015.
//  Copyright © 2015 Mark Tyers. All rights reserved.
//

import XCTest
/* the @testable keyword gives the testing framework access to private members of the specified class. */
@testable import Notes

class NotesTests: XCTestCase {
    
    func testAddNote() {
        Notes.getInstance.addNoteWithName("note1", content: "first note details")
        XCTAssertEqual(Notes.getInstance.count, 1)
        do {
            let note:Note = try Notes.getInstance.getNote(atIndex: 0)
            XCTAssertEqual(note.name, "note1")
            XCTAssertEqual(note.content, "first note details")
        } catch let e as NoteError {
            XCTAssertEqual(e, NoteError.indexOutOfRange)
        } catch {
            XCTFail("Wrong error")
        }
    }
    
}
