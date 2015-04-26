
import UIKit
import XCTest

class NoteSetTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        NoteSet.sharedInstance.addNote(Note(title: "Note 1", content: "Lorem Ipsum"))
        NoteSet.sharedInstance.addNote(Note(title: "Note 2", content: "Lorem Ipsum"))
    }
    
    override func tearDown() {
        NoteSet.sharedInstance.clear()
        super.tearDown()
    }
    
    func testAddNote() {
        NoteSet.sharedInstance.addNote(Note(title: "Note 3", content: "Lorem Ipsum"))
        XCTAssertEqual(NoteSet.sharedInstance.count, 3)
    }
    
    func testRemoveNote() {
        NoteSet.sharedInstance.removeNoteByTitle("Note 1")
        XCTAssertEqual(NoteSet.sharedInstance.count, 1)
    }
    
    func testFindNote() {
        self.measureBlock() {
            XCTAssertNotNil(NoteSet.sharedInstance.noteWithTitle("Note 2"))
        }
        XCTAssertNil(NoteSet.sharedInstance.noteWithTitle("Note 3"))
    }
    
    func testNoteAtIndex() {
        XCTAssertNotNil(NoteSet.sharedInstance.noteAtIndex(0))
        XCTAssertNil(NoteSet.sharedInstance.noteAtIndex(2))
        let note = NoteSet.sharedInstance.noteAtIndex(1)
        XCTAssertEqual(note!.noteTitle, "Note 2")
    }
    
}
