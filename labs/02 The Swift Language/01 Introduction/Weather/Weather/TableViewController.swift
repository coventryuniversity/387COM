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
    var icon:UIImage
}
/* this is an enumeration that conform to the 'ErrorType' protocol. It defines different but related errors that we can throw in our code. We will spend more time with protocol in the next worksheet. */
enum JSONError: ErrorType {
    case InvalidURL(String)
    case InvalidKey(String)
    case InvalidArray
    case InvalidData
    case InvalidImage
}

class TableViewController: UITableViewController {
    
    /* Here we declare an empty array to store Item structs. */
    var days:[Item] = []
    
    /* This is a function that takes a single 'String' parameter and returns nothing (Void). There are a couple of important features to note. First, all function declarations begin with the 'func' keyword. Secondly notice that Swift uses 'named parameters', in other words each parameter includes a label to describe its purpose. In our example the label is 'withCity'. Each parameter may also include a data type. here we are declaring that the parameter must be of type 'String'. The return value is indicated after the 'skinny arrow' If there is no return value the arrow and return type may be omitted. */
    func getForecast(withCity city: String) -> Void {
        /* when the app is retrieving data from the Internet you should display a small spinning indicator in the top status bar. */
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        /* if we are running any parts of a program that may conceivably fail these should be wrapped in a 'do' block. If an error does get triggered it will be caught in a 'catch' block that follows. */
        do {
            /* here we generate the URL to pass to the API by inserting our 'city' parameter. Notice how we use the \() syntax to insert the variable. */
            let jsonUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=7&q=\(city)"
            print(jsonUrl)
            /* NSURLSession provides the API for downloading content over HTTP */
            let session = NSURLSession.sharedSession()
            /* an NSURL object contains a valid reference to an online resource. Because the string we pass it may not be valid it could fail to create the NSURL object. Because of this we need to use a 'guard' conditional. This checks if the command fails and allows us to run a block of code to handle this. In this example we will throw a custom error. These errors are defined in the 'enum' at the top of this file. The error will be handled in the second catch block below. */
            guard let shotsUrl = NSURL(string: jsonUrl) else {
                throw JSONError.InvalidURL(jsonUrl)
            }
            /* Here we have an example of a method that takes two parameters. The first is the NSURL object we have just created but the second parameter is a 'completion handler'. A completion handler is an anonymous function passed as a parameter. This is declared inside a pair of curly braces {}. In the example below this function has three parameters and returns 'Void'. The method 'dataTaskWithURL creates a GET request and then runs the completion handler with the results. The data parameter contains the information found at the URL stored as an NSData object. */
            let task = session.dataTaskWithURL(shotsUrl, completionHandler: {(data, response, error) -> Void in
                do {
                    /* This method serialises the NSData into a JSON object ready for use in the app. If this fails it automatically throws an error. By adding the 'try' keyword it sends the error to the attached 'catch' block. */
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    print(json)
                    /* we have already covered the use of the guard condition. Each time we retrieve an array or object key from the json object we can't guarantee it will be there. By extracting the data piece by piece and making use of the guard condition we can safely extract the data from the json and report any errors if things go wrong without crashing the app. The 'AnyObject' data type means days can contain any valid Swift object. */
                    guard let days:[AnyObject] = (json["list"] as! [AnyObject]) else {
                        throw JSONError.InvalidArray
                    }
                    /* because the previous block didn't fail we know that 'days' contains a valid array which we can now loop through using the for...in loop. */
                    for day in days {
                        /* We can now extract each piece of data and store it in immutable variables. */
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
                        /* finally we use the data we extracted from the json object and use it to create an instance of our 'Item' struct. */
                        let newDay = Item(date: date, description: desc, maxTemp: max, icon: image)
                        /* We can now append this to the 'days' array we declared at the top of this class. */
                        self.days.append(newDay)
                        self.tableView.reloadData()
                    }
                /* this first catch block only catches a specific type or error. Since this error sends a String parameter we can use this to display helpful messages. */
                } catch JSONError.InvalidKey(let message) {
                    print("A JSON Key error has ocurred: \(message)")
                /* This second catch block handles any JSONError errors not handled by the previous block */
                } catch is JSONError {
                    print("a JSON error has occurred")
                /* This final catch handles any other errors. */
                } catch {
                    print("Fetch failed: \((error as NSError).localizedDescription)")
                }
                /* Now we have finished downloading data from the Internet we can hide the 'networkActivityIndicator' */
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
            task.resume()
        } catch {
            
        }
    }

    func refresh(sender: AnyObject) {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.tableView.delegate = self
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        /* there are two popular ways to handle JSON data in Swift. There is the built-in 'native' approach but there is also a popular library called 'SwiftyJSON' which provides a number of classes to make life easier. This class contains both approaches. By commenting and uncommenting the two lines below you can work with either approach. Notice that Swift uses 'named parameters'. Compare the function definition (above) with the calling syntax. */
        self.getForecast(withCity: "coventry,uk")
        /* here we can change the default row height for our UITableViewCell */
        self.tableView.rowHeight = 66.0
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /* This is the first of the 'Data Source' methods that control what gets displayed in each of the UITableViewCell objects. This one tells the app how many cells there shound be in the UITablwView. As you can see this will match the number of indexes in the 'days' array. */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.days.count
    }

    /* This is the second of two 'Data Source' methods. This one is where we describe what information will be displayed in a particular UITableViewCell. The app already knows how many rows to display in each section so as it needs to display a specific cell it calls this method. The second parameter 'indexPath' is an 'NSIndexPath' struct containing the 'section' and 'row' values. As you can see, this method returns a UITableViewCell containing the appropriate data. */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /* grabs any UITableViewCell object that is no longer visible (scrolled of screen). These are stored in a queue. If it can't find one to reuse it creates a new one. The 'cell idenfier' is a string we assigned to the UITableCell in interface builder to uniquely identify it. */
        let cell = tableView.dequeueReusableCellWithIdentifier("dailyForecast", forIndexPath: indexPath)
        /* print out the struct for the required index */
        print(days[indexPath.row])
        /* 'cell.textLabel' is an 'optional' value. This means it may not contain anything. If this is the case the app will crash if we try to access it (returns a 'nul' value). To prevent this we 'unwrap' it by trying to assign it to a local object, 'label'. If this succeeds we can use this local variable. If it fails then the conditional block is ignored. */
        if let label = cell.textLabel {
            /* the date for each forecast is being stored as an NSDate object. To display this as a string in the required format we need to make use of an NSDateFormatter. We assign a code to describe how we want to display the date in its 'dateFormat' property then pass the NSDate to its 'stringFromDate()' method. This returns our formatted string. */
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EE"
            label.text = formatter.stringFromDate(days[indexPath.row].date)
        }
        if let icon = cell.imageView {
            icon.image = days[indexPath.row].icon
        }
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
