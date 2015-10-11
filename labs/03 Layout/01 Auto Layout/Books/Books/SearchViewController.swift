
import UIKit

/* our subclass of UITableViewController implements the UISearchBarDelegate */
class SearchViewController: UITableViewController, UISearchBarDelegate {

    /* this outlet connects to the search bar in the storyboard. Click on the round circle in the left margin of the editor... */
    @IBOutlet weak var searchBar: UISearchBar!
    
    /* this variable will store the results of our searches. */
    var searchResults = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* the searchBar object refers to the @IBOutlet (see above). Our class implements the UISearchBarDelegate protocol and so can act as its *delegate*. A delegate listens out for messages emitted by a control or class. */
        self.searchBar.delegate = self
    }
    
    /* this is a UISearchBarDelegate method. By setting this class as the delegate for the searchBar it gets triggered each time the search button is pressed. */
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("search clicked")
        print(searchBar.text) // the searchbar has a text property that stores the string entered into the search bar.
        if let text:String = searchBar.text { // the searchBar.text property is an optional so we need to unwrap it before it can be accessed.
            self.search(withText: text)  // we now call our search() method (see below), passing the search string.
        }
    }
    
    /* this method gets called by the UISearchBar delegate method (see above) */
    func search(withText text:String) {
        do {  // our Books.search() class method may return an error so we wrap it in a do...catch block
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true // lets turn on the network activity indicator in the status bar...
            /* the Books.search() method takes two parameters, a search string and a completion handler. Notice the simplified syntax used here */
            try Books.search(withText: text, completion: {booklist in
                print(booklist)
                self.searchResults = booklist  // booklist contains the search results which need to be stored in the searchResults array
                dispatch_async(dispatch_get_main_queue(), { // any changes to the UI need to happen in the main thread.
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false  // we turn off the network activity indicator
                    self.tableView.reloadData()  // we reload the data into the table view
                    self.searchBar.resignFirstResponder()  // and we hide the keyboard
                })
            })
        } catch {
            print("error when searching for books")
        }
    }

    /* this method gets triggered whenever a segue is triggered */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {  // if the correct segue is triggered
            if let destination:DetailViewController = segue.destinationViewController as? DetailViewController {  // we get a reference to the controller that will be loaded
                if let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow { // we then find out which cell was clicked
                    destination.book = self.searchResults[indexPath.row] // finally we store the correct Book struct in the public variable in the controller that will be displayed.
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* this delegate method controls the edit actions for each table cell. These are triggered by swiping left on a cell. In this example we define one action but you can have as many of these as you wish. */
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        /* here we define our sole share action. Notice the three parameters. The first defines the style, the second is the label that appears and the final is a completion handler that runs when the action is clicked. */
        let shareAction = UITableViewRowAction(style: .Normal, title: "Share", handler: {(action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            let book = self.searchResults[indexPath.row]
            /* a UIActivityViewController offers various services from the underlying system. We pass the items we want to share and the system presents suitable services based on this information. */
            let activityViewController = UIActivityViewController(activityItems: [book.id, book.title], applicationActivities: nil)
            /* having configured the activityViewController we need to display it. */
            self.presentViewController(activityViewController, animated: true, completion: nil)
        })
        shareAction.backgroundColor = UIColor.grayColor()
        /* we return an array of the actions. These get displayed when we swipe a table cell left. */
        return [shareAction]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicSearchItem", forIndexPath: indexPath)
        if let label:UILabel = cell.textLabel {
            label.text = self.searchResults[indexPath.row].title
        }
        return cell
    }

}
