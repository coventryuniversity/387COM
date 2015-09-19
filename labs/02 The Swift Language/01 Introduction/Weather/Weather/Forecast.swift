
import Foundation

struct ForecastItem {
    var date:NSDate
    var description:String
    var maxTemp:Float
}

class Forecast {
    
    var city:String
    var forecasts = [ForecastItem]()
    
    init(withCity city: String) {
        print("City: \(city)")
        self.city = city
        print("self.city: \(self.city)")
        self.getForecast()
    }
    
    func getForecast() {
        let jsonUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=7&q=\(self.city)"
        print("jsonUrl: \(jsonUrl)")
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: jsonUrl)
        print(url)
        
        let task = session.dataTaskWithURL(url!, completionHandler: { (data: NSData?, response:NSURLResponse?,
            error: NSError?) -> Void in
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String:String]
                print(json)
            } catch {
                print("parsing error")
            }
        })
        task.resume()
    }
    
}



