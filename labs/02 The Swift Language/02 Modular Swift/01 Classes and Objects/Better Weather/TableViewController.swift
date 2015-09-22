//
//  TableViewController.swift
//  Better Weather
//
//  Created by Mark Tyers on 21/09/2015.
//  Copyright © 2015 Mark Tyers. All rights reserved.
//

import UIKit
import CoreLocation

/* this is a struct that describes the data required for each forecast item. */
struct Item {
    var date:NSDate
    var description:String
    var maxTemp:Float
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

class TableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var days:[Item] = []
    let locationManager = CLLocationManager()
    
    func refresh(sender: AnyObject) {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func configureCoreLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.activityType = CLActivityType.OtherNavigation
        self.locationManager.startUpdatingLocation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.tableView.delegate = self
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.configureCoreLocation()
        
        WeatherStatic.getForecast(withCity: "coventry,uk", forDays: 7, completionHandler: {(data) -> Void in
            self.days = data
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        })
        self.tableView.rowHeight = 66.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.days.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dailyForecast", forIndexPath: indexPath)
        if let label = cell.textLabel {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EE"
            label.text = formatter.stringFromDate(days[indexPath.row].date)
        }
        if let detail = cell.detailTextLabel {
            detail.text = days[indexPath.row].description
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
