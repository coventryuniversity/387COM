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
        let note1 = Note(title: "Hello", content: "World")
        NoteSet.sharedInstance.addNote(note1)
        println(NoteSet.sharedInstance.count)
        let helloNote:Note? = NoteSet.sharedInstance.noteWithTitle("Hello")
        if let note = helloNote {
            println(note)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

