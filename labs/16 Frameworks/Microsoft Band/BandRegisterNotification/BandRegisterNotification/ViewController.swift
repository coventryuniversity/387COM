//
//  ViewController.swift
//  BandRegisterNotification
//
//  Created by Mark Tyers on 22/06/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MSBClientManagerDelegate {

    var client:MSBClient!
    
    @IBOutlet weak var txtOutput: UITextView!

    @IBAction func runExampleCode(sender: UIButton) {
        if self.client.isDeviceConnected {
            self.output("Creating a tile...")
            var tileName = "Bell Tile"
            var tileID:NSUUID = NSUUID(UUIDString: "CCCDBA9F-12FD-47A5-83A9-E7270A43BB99")!
            var tileIcon = MSBIcon(UIImage: UIImage(named: "C"), error: nil)
            var smallIcon = MSBIcon(UIImage: UIImage(named: "Cc"), error: nil)
            var tile:MSBTile = MSBTile(id: tileID, name: tileName, tileIcon: tileIcon, smallIcon: smallIcon, error: nil)
            self.client.tileManager.addTile(tile, completionHandler: { (error) -> Void in
                if error == nil || error.localizedDescription == "Tile already exists." {
                    self.output("Registering notification...")
                    self.client.notificationManager.registerNotificationWithCompletionHandler({ (error) -> Void in
                        if error == nil {
                            self.output("Creating local notification....")
                            var itemDate = NSDate()
                            var localNotification = UILocalNotification()
                            localNotification.fireDate = itemDate.dateByAddingTimeInterval(20)
                            localNotification.timeZone = NSTimeZone.defaultTimeZone()
                            localNotification.alertBody = "Local Notification."
                            localNotification.alertAction = "View Details"
                            localNotification.soundName = UILocalNotificationDefaultSoundName
                            UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
                            self.output("Notification sent successfully!!!")
                            self.output("Please open C tile and verify the notification.")
                            self.output("You can remove the tile via Microsoft Health App.")
                        } else {
                            self.output(error.localizedDescription)
                        }
                    })
                    
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
        self.output("viewDidLoad")
        MSBClientManager.sharedManager().delegate = self
        var clients = MSBClientManager.sharedManager().attachedClients()
        if let _client:MSBClient = clients[0] as? MSBClient {
            client = _client
            MSBClientManager.sharedManager().connectClient(client)
            self.output("Please wait. Connecting to Band...")
            // configuring notifications
            var types = UIUserNotificationType.Badge | UIUserNotificationType.Sound | UIUserNotificationType.Alert
            var mySettings = UIUserNotificationSettings(forTypes: types, categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        } else {
            self.output("Failed! No Bands attached.")
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clientManager(clientManager: MSBClientManager!, clientDidConnect client: MSBClient!) {
        self.output("Band connected.")
    }
    
    func clientManager(clientManager: MSBClientManager!, clientDidDisconnect client: MSBClient!) {
        self.output("Band disconnected.")
    }
    
    func clientManager(clientManager: MSBClientManager!, client: MSBClient!, didFailToConnectWithError error: NSError!) {
        self.output("Failed to connect to Band.")
        self.output(error.description)
    }
    
    func output(string:String) {
        var current = self.txtOutput.text
        self.txtOutput.text = current+"\n"+string
    }

}

