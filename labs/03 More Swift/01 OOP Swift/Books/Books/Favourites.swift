
import Foundation

class Favourites {
    
    private var books:[Book]
    
    /* here is a static (class) public property that returns a Favourites object */
    static let sharedInstance = Favourites()
    
    /* notice the initializer is private, meaning it can't be directly accessed */
    private init() {
        self.books = []
    }
    
    /* this method adds a book to the favourites object */
    func addBook(book:Book) {
        self.books.append(book)
    }
    
    /* this defines a read-only calculated property. */
    var bookList:[Book] {
        get {
            return self.books
        }
        /*
        set {
            // code goes here to update the property (not appropriate for this property!)
        }
        */
    }
}