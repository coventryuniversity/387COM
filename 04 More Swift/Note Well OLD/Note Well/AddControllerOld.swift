//
//  AddController.swift
//  Note Well
//
//  Created by Mark Tyers on 26/04/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit

class AddController: UIViewController {
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteContent: UITextView!
    

    @IBAction func closeView(sender: UIBarButtonItem) {
        NoteSet.sharedInstance.addNote(Note(title: "Note 1", content: "Lorem Ipsum"))
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
