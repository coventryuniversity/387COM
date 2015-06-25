//
//  ViewController.swift
//  BandNotification
//
//  Created by Mark Tyers on 22/06/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MSBClientManagerDelegate {
    
    var client:MSBClient!
    
    @IBOutlet weak var txtOutlet: UITextView!
    
    @IBAction func runExampleCode(sender: UIButton) {
        if self.client.isDeviceConnected {
            self.output("Creating tile...")
            var tileName = "Book Tile"
            var tileID:NSUUID = NSUUID(UUIDString: "DCBABA9F-12FD-47A5-83A9-E7270A4399BB")!
            var tileIcon = MSBIcon(UIImage: UIImage(named: "B"), error: nil)
            var smallIcon = MSBIcon(UIImage: UIImage(named: "Bb"), error: nil)
            var tile:MSBTile = MSBTile(id: tileID, name: tileName, tileIcon: tileIcon, smallIcon: smallIcon, error: nil)
            self.client.tileManager.addTile(tile, completionHandler: { (error) -> Void in
                if error == nil || error.localizedDescription == "Tile already exists." {
                    self.output("Sending notification...")
                    self.client.notificationManager.sendMessageWithTileID(tileID, title: "Hello", body: "Hello World!", timeStamp: NSDate(), flags: MSBNotificationMessageFlags.ShowDialog, completionHandler: { (error) -> Void in
                        if error == nil {
                            self.output("Successfully Finished!!! You can remove tile via Microsoft Health App.")
                        } else {
                            self.output(error.localizedDescription)
                        }
                    })
                } else {
                    println(error.localizedDescription)
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad")
        MSBClientManager.sharedManager().delegate = self
        var clients = MSBClientManager.sharedManager().attachedClients()
        if let _client:MSBClient = clients[0] as? MSBClient {
            client = _client
            MSBClientManager.sharedManager().connectClient(client)
            println("Please wait. Connecting to Band...")
            self.output("Please wait. Connecting to Band...")
        } else {
            println("Failed! No Bands attached.")
            self.output("Failed! No Bands attached.")
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clientManager(clientManager: MSBClientManager!, clientDidConnect client: MSBClient!) {
        println("Band connected.")
        self.output("Band connected.")
    }
    
    func clientManager(clientManager: MSBClientManager!, clientDidDisconnect client: MSBClient!) {
        println("Band disconnected.")
    }
    
    func clientManager(clientManager: MSBClientManager!, client: MSBClient!, didFailToConnectWithError error: NSError!) {
        println("Failed to connect to Band.")
        println(error.description)
    }
    
    func output(string:String) {
        var current = self.txtOutlet.text
        self.txtOutlet.text = current+"\n"+string
    }

}

