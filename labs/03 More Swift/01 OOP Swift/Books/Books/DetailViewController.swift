//
//  DetailViewController.swift
//  Books
//
//  Created by Mark Tyers on 10/10/2015.
//  Copyright © 2015 Mark Tyers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // this public variable will be assigned a value in the prepareForSegue method in the SearchViewController
    var book:Book?
    
    // this @IBOutlet connects to the label in the view. Click on the round dot in the left margin for details.
    @IBOutlet weak var titleLabel: UILabel!

    /* this gets run as soon as the view loads */
    override func viewDidLoad() {
        super.viewDidLoad()
        /* because book is declared as an optional it needs unwrapping before it can be used. */
        if let book:Book = self.book {
            print(book.id)
            self.titleLabel.text = book.title  // display the book title on the new view in the label.
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
