
import UIKit

class ListViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        print("viewDidLoad:       ListViewController")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear:    ListViewController")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear:     ListViewController")
        /* each time the view becomes visible we reload the table view */
        print("there are \(Notes.getInstance.count) notes")
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("viewWillDisappear: ListViewController")
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("viewDidDisappear:  ListViewController")
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
        /* the number of rows should match the number of notes in the singleton */
        return Notes.getInstance.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell", forIndexPath: indexPath)
        do {
            /* .getNote() may propagate an error which needs to be handled. */
            let date:NSDate = try Notes.getInstance.getNote(atIndex: indexPath.row).created
            // unwrap the textLabel optional
            if let label = cell.textLabel {
                // display the note creation date
                label.text = "\(date)"
            }
        } catch {
            print("index out of range")
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
