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
    
    override func setUp() {
        Notes.getInstance.clear()
        Notes.getInstance.addNoteWithName("note1", content: "first note details")
        Notes.getInstance.addNoteWithName("note2", content: "second note details")
        Notes.getInstance.addNoteWithName("note3", content: "third note details")
        Notes.getInstance.addNoteWithName("note4", content: "fourth note details")
        XCTAssertEqual(Notes.getInstance.count, 4)
    }
    
    func testAddNote() {
        do {
            let note:Note = try Notes.getInstance.getNote(atIndex: 0)
            XCTAssertEqual(note.name, "note1")
            XCTAssertEqual(note.content, "first note details")
            let _:Note = try Notes.getInstance.getNote(atIndex: -2)
            let _:Note = try Notes.getInstance.getNote(atIndex: 4)
        } catch let e as NoteError {
            XCTAssertEqual(e, NoteError.indexOutOfRange)
        } catch {
            XCTFail("Wrong error")
        }
    }
    
    func testAddNoteUnique() {
        do {
            try Notes.getInstance.addNoteWithUniqueName("note5", content: "fifth note details")
            XCTAssertEqual(Notes.getInstance.count, 5)
        } catch {
            XCTFail("Wrong error")
        }
    }
    
    func testAddNoteNotUnique() {
        do {
            defer {
                XCTAssertEqual(Notes.getInstance.count, 4)
            }
            try Notes.getInstance.addNoteWithUniqueName("note3", content: "third note details")
            XCTFail("Should not reach this line")
        } catch let e as NoteError {
            XCTAssertEqual(e, NoteError.duplicateNote)
        } catch {
            XCTFail("Wrong error")
        }
    }
    
}
