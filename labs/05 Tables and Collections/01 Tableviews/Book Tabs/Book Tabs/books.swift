
import Foundation

struct Book {
    var id:String
    var title:String
    var publisher:String
}

enum JSONError: ErrorType {
    case InvalidURL
    case InvalidKey(String)
    case InvalidArray
    case InvalidData
    case InvalidImage
    case indexOutOfRange
}

class Books {
    private var books:[Book]
    private var publishers = Set<String>()
    
    init(withSubject subject:String, completion: ()->() ) throws {
        print("init")
        self.books = []
        guard let url = NSURL(string: "https://www.googleapis.com/books/v1/volumes?maxResults=40&fields=items(id,volumeInfo(title,%20publisher))&q=\(subject)") else {
            throw JSONError.InvalidURL
        }
        print("valid URL: \(url)")
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url, completionHandler: {(data, response, error) -> Void in
            do {
                print("trying to access json data")
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                guard let items:[AnyObject] = (json["items"] as! [AnyObject]) else {
                    throw JSONError.InvalidArray
                }
                for item in items {
                    print(item)
                    guard let id:String = item["id"] as? String else {
                        throw JSONError.InvalidKey("id")
                    }
                    guard let volume:AnyObject = item["volumeInfo"] else {
                        throw JSONError.InvalidKey("volumeInfo")
                    }
                    guard let title:String = volume["title"] as? String else {
                        throw JSONError.InvalidKey("title")
                    }
                    guard let publisher:String = volume["publisher"] as? String else {
                        throw JSONError.InvalidKey("publisher")
                    }
                    let newBook = Book(id: id, title: title, publisher: publisher)
                    print(newBook)
                    self.books.append(newBook)
                }
                for book in self.books {
                    self.publishers.insert(book.publisher)
                }
                print(self.publishers)
                completion()
            } catch {
                print("Fetch failed: \((error as NSError).localizedDescription)")
            }
        })
    }
    
    private func getBooks() {
        
    }
}