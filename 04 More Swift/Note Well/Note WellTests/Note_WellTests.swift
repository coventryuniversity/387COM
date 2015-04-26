
import UIKit
import XCTest

class Note_WellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        NoteSet.sharedInstance.addNote(Note(title: "Note 1", content: "Lorem Ipsum"))
        NoteSet.sharedInstance.addNote(Note(title: "Note 2", content: "Lorem Ipsum"))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddNote() {
        NoteSet.sharedInstance.addNote(Note(title: "Note 3", content: "Lorem Ipsum"))
        XCTAssertEqual(NoteSet.sharedInstance.count, 3)
    }
    
    func testFindNote() {
        let note1 = Note(title: "Hello", content: "World")
        NoteSet.sharedInstance.addNote(note1)
        self.measureBlock() {
            XCTAssertNotNil(NoteSet.sharedInstance.noteWithTitle("Hello"))
        }
        XCTAssertNil(NoteSet.sharedInstance.noteWithTitle("Goodbye"))
    }
    
}
