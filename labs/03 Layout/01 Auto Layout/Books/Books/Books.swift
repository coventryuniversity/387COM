
import Foundation
import UIKit

struct Book {
    var id:String
    var title:String
}

enum JSONError: ErrorType {
    case InvalidURL(String)
    case InvalidKey(String)
    case InvalidArray
    case InvalidData
    case InvalidImage
    case indexOutOfRange
}

class Books {
    
    class func search(withText text:String, completion: ([Book])->()) throws {
        var books = [Book]()
        let jsonUrl = "https://www.googleapis.com/books/v1/volumes?maxResults=40&fields=items(id,volumeInfo(title))&q=\(text)"
        print(jsonUrl)
        let session = NSURLSession.sharedSession()
        
        guard let booksUrl = NSURL(string: jsonUrl) else {
            throw JSONError.InvalidURL(jsonUrl)
        }
        session.dataTaskWithURL(booksUrl, completionHandler: {(data, response, error) -> Void in
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                //print(json)
                guard let items:[AnyObject] = (json["items"] as! [AnyObject]) else {
                    throw JSONError.InvalidArray
                }
                for item in items {
                    guard let id:String = item["id"] as? String else {
                        throw JSONError.InvalidKey("id")
                    }
                    guard let volume:AnyObject = item["volumeInfo"] else {
                        throw JSONError.InvalidKey("volumeInfo")
                    }
                    guard let title:String = volume["title"] as? String else {
                        throw JSONError.InvalidKey("title")
                    }
                    let newBook = Book(id: id, title: title)
                    print(newBook)
                    books.append(newBook)
                }
            } catch {
                print("Fetch failed: \((error as NSError).localizedDescription)")
                //throw JSONError.InvalidURL(jsonUrl)
            }
            completion(books)
        }).resume()
    }
}