//
//  SearchViewController.swift
//  Books
//
//  Created by Mark Tyers on 09/10/2015.
//  Copyright © 2015 Mark Tyers. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults = [Book]()
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("search clicked")
        print(searchBar.text)
        if let text:String = searchBar.text {
            self.search(withText: text)
        }
    }
    
    func search(withText text:String) {
        do {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            try Books.search(withText: text, completion: {booklist in
                print(booklist)
                self.searchResults = booklist
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    self.tableView.reloadData()
                    self.searchBar.resignFirstResponder()
                })
            })
        } catch {
            print("error when searching for books")
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            if let destination:DetailViewController = segue.destinationViewController as? DetailViewController {
                if let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow {
                    destination.book = self.searchResults[indexPath.row]
                }
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        //self.search()
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
        return self.searchResults.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicSearchItem", forIndexPath: indexPath)
        if let label:UILabel = cell.textLabel {
            label.text = self.searchResults[indexPath.row].title
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
