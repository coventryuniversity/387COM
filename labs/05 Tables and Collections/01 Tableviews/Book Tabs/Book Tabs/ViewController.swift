//
//  ViewController.swift
//  Book Tabs
//
//  Created by Mark Tyers on 28/10/2015.
//  Copyright © 2015 Coventry University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var booklist:Books?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        do {
            self.booklist = try Books(withSubject: "swift", completion: {() in
                print("finished downloading data")
            })
        } catch {
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

