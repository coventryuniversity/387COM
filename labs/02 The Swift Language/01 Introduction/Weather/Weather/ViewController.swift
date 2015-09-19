
/* to allow the app to load data over an insecure connection (HTTP) you need to add
   the NSAllowArbitraryLoads key to your info.plist and set it to YES. This has already
   been done for this project.*/

import UIKit

struct Item {
    var date:NSDate
    var description:String
    var maxTemp:Float
}

class ViewController: UIViewController {
    
    var days:[Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        let jsonUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=7&q=coventry,uk"
        
        let session = NSURLSession.sharedSession()
        let shotsUrl = NSURL(string: jsonUrl)
        print(shotsUrl)
        let task = session.dataTaskWithURL(shotsUrl!) { (data, response, error) -> Void in
            print("dataTaskWithURL")
            let json = JSON(data: data!)
            let days = json["list"]
            print(days)
            for (_,day):(String, JSON) in days {
                let time = NSTimeInterval(day["dt"].double!)
                let date = NSDate(timeIntervalSince1970: time)
                let newDay = Item(date: date, description: day["weather"][0]["description"].string!, maxTemp: day["temp"]["max"].float!)
                self.days.append(newDay)
            }
            print(self.days)
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

