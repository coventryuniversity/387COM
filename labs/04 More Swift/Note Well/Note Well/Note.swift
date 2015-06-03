
import UIKit

class Note: NSObject {
    // creating two private properties
    private var title:String!
    private var content:String!
    private var added:NSDate!
    
    // creating an initialiser (constructor)
    init(title:String, content:String) {
        self.title = title
        self.content = content
        self.added = NSDate()
    }
    
    var noteTitle:String {
        set {
            self.title = newValue
        }
        get {
            return self.title
        }
    }
    
    var noteContent:String {
        set {
            self.content = newValue
        }
        get {
            return self.content
        }
    }
    
    var noteAdded:NSDate {
        set {
            self.added = newValue
        }
        get {
            return self.added
        }
    }
    
    // property to return a string representation of the object
    override var description:String {
        return "title: \(self.title) \n \(self.content)"
    }
}
