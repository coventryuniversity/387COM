
import UIKit

class NoteSet: NSObject {
    static let sharedInstance:NoteSet = NoteSet()
    private var notes:[Note]
    
    private override init() {
        notes = [Note]()
    }
    
    func addNote(note:Note) -> Bool {
        notes.append(note)
        return true
    }
    
    // this function returns an optional
    func noteWithTitle(title:String) -> Note? {
        for note in notes {
            if note.noteTitle == title {
                return note
            }
        }
        return nil
    }
    
    var count:Int {
        return notes.count
    }
}
