
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
    
    func clear() {
        self.notes.removeAll(keepCapacity: false)
    }
    
    func noteAtIndex(index:Int) -> Note? {
        if index > notes.count - 1 {
            return nil
        } else {
            println(index)
            return notes[index]
        }
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
    
    func removeNoteByTitle(title:String) {
        for (index, element:Note) in enumerate(notes) {
            if element.noteTitle == title {
                notes.removeAtIndex(index)
                break
            }
        }
    }
    
    func removeNoteByIndex(index:Int) {
        if index < notes.count {
            notes.removeAtIndex(index)
        }
    }
    
    var count:Int {
        return notes.count
    }
}
