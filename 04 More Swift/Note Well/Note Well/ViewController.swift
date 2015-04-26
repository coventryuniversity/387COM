//
//  ViewController.swift
//  Note Well
//
//  Created by Mark Tyers on 26/04/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var notes = NoteSet.sharedInstance
        let note1 = Note(title: "Hello", content: "World")
        notes.addNote(note1)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

