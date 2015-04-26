
import UIKit

class Note: NSObject {
    // creating two private properties
    private var title:String!
    private var content:String!
    
    // creating an initialiser (constructor)
    init(title:String, content:String) {
        self.title = title
        self.content = content
    }
    
    // property to return a string representation of the object
    override var description:String {
        return "title: \(self.title) \n \(self.content)"
    }
}
