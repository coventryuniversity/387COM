
import UIKit

/* An enumeration groups together related values. They conform to the **ErrorType** protocol. This indicates a type that can be used for    error-handling. */
enum TodoError: ErrorType {
    case indexOutOfRange
    case duplicateItem
}

/* A struct (structured data type) representing an item added to the list. Notice that there are four properties, two of which are assigned default values. */
struct Item {
    var title:String
    var description:String
    var added:NSDate = NSDate()
    var done:Bool = false
}

/// The **Todo** class handles the creation and maintaining of lists such as those used for shopping.
///
/// Overview
///
/// A todo object provides support for the following activities:
///
/// 1. adding new items
/// 2. retrieving items based on their index
///
class Todo {
    private var items:[String]
    
    /// creates a new Todo object
    init() {
        // initialises the empty array
        self.items = []
    }
    
    /// creates a new Todo object
    /// - parameters:
    ///   - [String]: An array containing the items to be added.
    init(withArray list:[String]) {
        // initialises the array with the array parameter.
        self.items = list
    }
    
    /// adds a new item to the list
    /// - parameters:
    ///   - String: The item to be added.
    func addItem(item:String) {
        self.items.append(item)
    }
    
    /// adds a new item to the list
    /// - parameters:
    ///   - Int: The index of the list item to be returned.
    /// - throws: A `TodoError.indexOutOfRange` error, if the index is invalid.
    /// - returns: A string containing the list item.
    func getItem(atIndex index:Int) throws -> String {
        // because the index may be out of range we use a guard statement to see if we can retrieve the string at the defined index
        guard let i:String = self.items[index] else {
            // if this fails we need to throw an error
            throw TodoError.indexOutOfRange
        }
        // if the guard statement succeeds we have a valid string value and can return it.
        return i
    }
    
}

