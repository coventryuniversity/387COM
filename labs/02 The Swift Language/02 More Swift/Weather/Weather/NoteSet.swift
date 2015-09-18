
import Cocoa

class NoteSet: NSObject {
    static let sharedInstance:NoteSet = NoteSet()
    var notes:[Note]
    
    override init() {
        notes = [Note]()
    }
    
    func addNote(note:Note) -> Bool {
        notes.append(note)
        return true
    }
}

