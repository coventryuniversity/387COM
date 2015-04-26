
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
}
