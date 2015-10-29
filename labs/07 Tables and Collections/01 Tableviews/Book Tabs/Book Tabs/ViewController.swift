//
//  ViewController.swift
//  Book Tabs
//
//  Created by Mark Tyers on 28/10/2015.
//  Copyright © 2015 Coventry University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var bookResults = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.search(withText: "swift")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func search(withText text:String) {
        do {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            try Books.search(withText: text, completion: {booklist in
                print(booklist)
                self.bookResults = booklist
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    //self.tableView.reloadData()
                    //self.searchBar.resignFirstResponder()
                })
            })
        } catch {
            print("error when searching for books")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

