//
//  Note.swift
//  Notes
//
//  Created by Mark Tyers on 22/09/2015.
//  Copyright © 2015 Mark Tyers. All rights reserved.
//

import Foundation

struct Note {
    var created: NSDate = NSDate()
    var name:String
    var content:String
}

enum NoteError: ErrorType, Equatable {
    case indexOutOfRange
}

/// a class for storing and retrieving a list of notes.
class Notes {
    /* this is the private array to store the list of notes. It is not visible from other parts of the app. */
    private var noteList:[Note]
    /**
     returns the a shared instance of the notes class. This can be shared between different views and as such doesn't need to be held in a public variable within the view controller.
     */
    static let getInstance = Notes()
    
    /* this is the initialiser. Note that it is private and so can't be accessed directly. */
    private init() {
        self.noteList = []
    }
    
    
    /// Adds a new note to the list of notes.
    ///
    /// :param: title The name of the new note
    /// :param: note The text to be stored in the note
    func addNoteWithName(name:String, content note:String) {
        let newNote = Note(created: NSDate(), name: name, content: note)
        self.noteList.append(newNote)
    }
    
    
    /// Retrieves the note at the given index position
    ///   :param: index The index position requested
    ///   :returns: A Note struct representing the requested note

    /* notice that this function may throw an error (if the index is out of range). This is indicated by the keyword **throws** in the function declaration. The function will either return a **Note** or an **indexOutOfRange** error. */
    func getNote(atIndex index: Int) throws -> Note {
        if index < 0 || index > self.noteList.count {
            throw NoteError.indexOutOfRange
        }
        let note = self.noteList[index]
        return note
    }
    
    /// read-only property that returns the number of notes stored.
    var count:Int {
        get {
            return self.noteList.count
        }
    }
}
