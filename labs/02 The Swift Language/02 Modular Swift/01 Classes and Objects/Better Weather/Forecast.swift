
import Foundation
import UIKit

class Forecast {
    
    var forecast = [Item]()
    
    init() {
        
    }
    
    func loadData(dataHandler: ([Item])->()) throws {
        print("a")
        var items = [Item]()
        let jsonUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=7&q=coventry,uk"
        print(jsonUrl)
        print("b")
        let session = NSURLSession.sharedSession()
        guard let shotsUrl = NSURL(string: jsonUrl) else {
            print("c")
            throw JSONError.InvalidURL(jsonUrl)
        }
        print(shotsUrl)
        session.dataTaskWithURL(shotsUrl, completionHandler: {(data, response, error) -> Void in
            do {
                print("d")
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
                    guard let desc:String = weather[0]["description"] as? String else {
                        throw JSONError.InvalidKey("description")
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
                    guard let temp:AnyObject = day["temp"] else {
                        throw JSONError.InvalidKey("temp")
                    }
                    guard let max:Float = temp["max"] as? Float else {
                        throw JSONError.InvalidKey("max")
                    }
                    let newDay = Item(date: date, description: desc, maxTemp: max, icon: image)
                    print(newDay)
                    items.append(newDay)
                }
                dataHandler(items)
            } catch {
                print("Fetch failed: \((error as NSError).localizedDescription)")
            }
        })
    }
    
    func getForecast() -> [Item] {
        return self.forecast
    }
}
