//
//  TableViewController.swift
//  Weather
//
//  Created by Mark Tyers on 19/09/2015.
//  Copyright © 2015 Mark Tyers. All rights reserved.
//

import UIKit
/* this is a struct that describes the data required for each forecast item. */
struct Item {
    var date:NSDate
    var description:String
    var maxTemp:Float
}
/* this is an enumeration that conform to the 'ErrorType' protocol. It defines different but related errors that we can throw in our code. We will spend more time with protocol in the next worksheet. */
enum JSONError: ErrorType {
    case InvalidKey(String)
    case InvalidArray
}

class TableViewController: UITableViewController {
    
    /* Here we declare an empty array to store Item structs. */
    var days:[Item] = []
    
    /* here we define a private function that is not visible outside the class. It takes a single String parameter and returns nothing (Void). */
    private func useSwifty(withCity city: String) -> Void {
        /* to make it easier to follow this code, paste the following URL into a new browser tab. The 'let' keyword creates an 'immutable' variable (sometimes called a constant). Notice that the 'city' parameter is inserted into the string.*/
        let jsonUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=7&q=\(city)"
        /* to find out about the NSURLSession class, click on it then open the 'Quick Help' in the right-hand panel in XCode */
        let session = NSURLSession.sharedSession()
        let shotsUrl = NSURL(string: jsonUrl)
        //print(shotsUrl)
        /* This code creates a named task. There are two parameters here: the NSURL object and an anonymous function (callback). Take a few minutes to make sense of the syntax. The second (callback) parameter is between curly braces {}. It provides three parameters (data, response and error) and returns nothing (Void). */
        let task = session.dataTaskWithURL(shotsUrl!) { (data, response, error) -> Void in
            //print("dataTaskWithURL")
            do {
                /* the callback sends the response as an NSData object. We create a new JSON object passing the NSData object. This gives us a JSON object we can parse easily. */
                let json = JSON(data: data!)
                let days = json["list"]
                //print(days)
                /* 'days' is an array of JSON objects. We need to iterate through this to extract the forecast for each day. 'index' contains the array index (stored as a String) whilst 'element' is a JSON object. */
                for (index,element):(String, JSON) in days {
                    /* notice how we interpolate variables within a string. */
                    print("key: \(index)")
                    /* There is no guarantee that the JSON data contains the required key. If this is missing a 'nul' value is returned. If this is the case we need to stop and throw an error. We need to pass a string to this particular error */
                    guard let timestamp = element["dt"].double else {
                        throw JSONError.InvalidKey("day[\(index)].dt.double")
                    }
                    /* this next line does not use a guard statement. Can you fix it? */
                    let desc = element["weather"][0]["description"].stringValue
                    /* we need to turn the timestamp into an NSDate. The NSDate constructor requires an NSTimeInterval object. Open the utilities (right) pane on the **Quick Help** tab then try clicking on each class (in purple) to view the documentation */
                    let date = NSDate(timeIntervalSince1970: NSTimeInterval(timestamp))
                    /* now we create an 'Item' struct using the data from the JSON document. Notice that the 'maxTemp' value is extracted in-line. Add code to store this value in an immutable variable, throwing an error if it can't be found. */
                    let newDay = Item(date: date, description: desc, maxTemp: element["temp"]["max"].float!)
                    self.days.append(newDay)
                }
                //print(self.days)
                self.tableView.reloadData()
            } catch JSONError.InvalidKey(let message) {
                /* Here we catch a specific error. The message contains the string we passed when the error was thrown. */
                print("A JSON Key error has ocurred: \(message)")
            } catch is JSONError {
                /* this block of code will catch any JSONError */
            } catch {
                /* this block will catch any errors not caught by the previous blocks */
            }
        }
        task.resume()
        self.tableView.reloadData()
    }
    
    func useNative() {
        
    }
    
    func refresh(sender: AnyObject) {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        /* there are two popular ways to handle JSON data in Swift. There is the built-in 'native' approach but there is also a popular library called 'SwiftyJSON' which provides a number of classes to make life easier. This class contains both approaches. By commenting and uncommenting the two lines below you can work with either approach. Notice that Swift uses 'named parameters'. Compare the function definition (above) with the calling syntax. */
        self.useSwifty(withCity: "coventry,uk")
        //self.useNative()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.days.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dailyForecast", forIndexPath: indexPath)
        print(days[indexPath.row])
        cell.textLabel?.text = days[indexPath.row].description

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
