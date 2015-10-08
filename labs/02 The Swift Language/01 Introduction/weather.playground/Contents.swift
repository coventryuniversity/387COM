
import UIKit
import XCPlayground
XCPSetExecutionShouldContinueIndefinitely(true)

struct Item {
    var date:NSDate
    var icon:UIImage
}

enum JSONError: ErrorType {
    case InvalidURL(String)
    case InvalidKey(String)
    case InvalidArray
    case InvalidData
    case InvalidImage
    case indexOutOfRange
}

var items = [Item]()
let jsonUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=7&q=coventry,uk"
print(jsonUrl)
let session = NSURLSession.sharedSession()
guard let shotsUrl = NSURL(string: jsonUrl) else {
    throw JSONError.InvalidURL(jsonUrl)
}

session.dataTaskWithURL(shotsUrl, completionHandler: {(data, response, error) -> Void in
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
        print(json)
        guard let days:[AnyObject] = (json["list"] as! [AnyObject]) else {
            throw JSONError.InvalidArray
        }
        for day in days {
            guard let timestamp:Double = day["dt"] as? Double else {
                throw JSONError.InvalidKey("dt")
            }
            print(timestamp)
            let date = NSDate(timeIntervalSince1970: NSTimeInterval(timestamp))
            guard let weather:[AnyObject] = day["weather"] as? [AnyObject] else {
                throw JSONError.InvalidArray
            }
            guard let icon:String = weather[0]["icon"] as? String else {
                throw JSONError.InvalidKey("icon")
            }
            guard let url = NSURL(string: "http://openweathermap.org/img/w/\(icon).png") else {
                throw JSONError.InvalidURL("http://openweathermap.org/img/w/\(icon).png")
            }
            guard let data = NSData(contentsOfURL: url) else {
                throw JSONError.InvalidData
            }
            guard let image = UIImage(data: data) else {
                throw JSONError.InvalidImage
            }
            let newDay = Item(date: date, icon: image)
            print(newDay)
            items.append(newDay)
        }
        print(items)
    } catch {
        print("Fetch failed: \((error as NSError).localizedDescription)")
    }
}).resume()