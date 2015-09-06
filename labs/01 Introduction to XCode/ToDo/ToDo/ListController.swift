//
//  ListController.swift
//  ToDo
//
//  Created by Mark Tyers on 06/09/2015.
//  Copyright © 2015 Coventry University. All rights reserved.
//

import UIKit

class ListController: UITableViewController {
    
    var items:[String] = ["Bread", "Butter"]
    //var savedItems:NSUserDefaults
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row: "+String(indexPath.row))
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    @IBAction func editMode(sender: UIBarButtonItem) {
        print("editMode")
        self.editing = !self.editing
        if (self.editing == true) {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    
    @IBAction func showDialog(sender: UIBarButtonItem) {
        print("showDialog")
        let alert = UIAlertController(title: "New Item", message: "Type item below", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            if let item:String = alert.textFields![0].text {
                print(item)
                self.items.append(item)
                print(self.items)
                self.saveList()
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveList() {
        let savedItems = NSUserDefaults.standardUserDefaults()
        savedItems.setObject(items, forKey: "items")
        savedItems.synchronize()
        print("list saved")
    }

    
    func refresh(sender:AnyObject) {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let savedItems = NSUserDefaults.standardUserDefaults()
        if let loadedItems:[String] = savedItems.objectForKey("items") as? [String] {
            print("data loaded")
            print(loadedItems)
            self.items = loadedItems
        }
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShoppingItem", forIndexPath: indexPath)
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not wantthe specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            self.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.saveList()
        }
    }
    

    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let item:String = items[fromIndexPath.row]
        self.items.removeAtIndex(fromIndexPath.row)
        items.insert(item, atIndex: toIndexPath.row)
        self.tableView.reloadData()
        self.saveList()
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
