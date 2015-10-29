
import XCTest
/* the @testable keyword gives the testing framework access to private members of the specified class. */
@testable import Notes

/* this is the test suite. To run the tests you can click on the diamond symbol in the gutter next to the class declaration or choose Product > Test from the menu or press 'cmd+U' */
class NotesTests: XCTestCase {
    
    /* this method gets called before each test. We clear the old notes and add some known ones. Tests can be run individually. */
    override func setUp() {
        Notes.getInstance.clear()
        Notes.getInstance.addNoteWithName("note1", content: "first note details")
        Notes.getInstance.addNoteWithName("note2", content: "second note details")
        Notes.getInstance.addNoteWithName("note3", content: "third note details")
        Notes.getInstance.addNoteWithName("note4", content: "fourth note details")
        /* we compare the number of notes with the integer 4. This is a test that fails if these are not equal. */
        XCTAssertEqual(Notes.getInstance.count, 4)
    }
    
    func testAddNote() {
        do {
            let note:Note = try Notes.getInstance.getNote(atIndex: 0)
            /* we can use XCAssertEqual to compare strings as well as integers. */
            XCTAssertEqual(note.name, "note1")
            XCTAssertEqual(note.content, "first note details")
            let _:Note = try Notes.getInstance.getNote(atIndex: -2)
            let _:Note = try Notes.getInstance.getNote(atIndex: 4)
        } catch let e as NoteError {
            /* we can also check the correct error has been thrown. */
            XCTAssertEqual(e, NoteError.indexOutOfRange)
        } catch {
            /* and check that certain sections of code are never called. */
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
            /* the 'defer' step includes code that should _always_ be run, even after an error has been thrown. */
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
