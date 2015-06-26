//
//  ViewController.swift
//  BandTileEvent
//
//  Created by Mark Tyers on 22/06/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MSBClientManagerDelegate, MSBClientTileDelegate {
    
    var client:MSBClient!
    @IBOutlet weak var txtOutlet: UITextView!
    
    @IBAction func runExampleCode(sender: UIButton) {
        if self.client.isDeviceConnected {
            self.output("Creating tile...")
            // Create a Tile
            var tileName = "Button Tile"
            var tileID:NSUUID = NSUUID(UUIDString: "DCBABA9F-12FD-47A5-83A9-E7270A4399BB")!
            var tileIcon = MSBIcon(UIImage: UIImage(named: "D"), error: nil)
            var smallIcon = MSBIcon(UIImage: UIImage(named: "Dd"), error: nil)
            var tile:MSBTile = MSBTile(id: tileID, name: tileName, tileIcon: tileIcon, smallIcon: smallIcon, error: nil)
            // Create a Text Block
            var textBlock:MSBPageTextBlock = MSBPageTextBlock(rect: MSBPageRect(x: 0, y: 0, width: 200, height: 40), font: MSBPageTextBlockFont.Small)
            textBlock.elementId = 10
            textBlock.baseline = 25
            textBlock.baselineAlignment = MSBPageTextBlockBaselineAlignment.Relative
            textBlock.horizontalAlignment = MSBPageHorizontalAlignment.Center
            textBlock.autoWidth = false
            textBlock.color = MSBColor(red: 255, green: 0, blue: 0)
            textBlock.margins = MSBPageMargins(left: 5, top: 2, right: 5, bottom: 2)
            // Create a Text Button
            var button = MSBPageTextButton(rect: MSBPageRect(x: 0, y: 0, width: 200, height: 40))
            button.elementId = 11
            button.horizontalAlignment = MSBPageHorizontalAlignment.Center
            button.pressedColor = MSBColor(red: 255, green: 0, blue: 255)
            button.margins = MSBPageMargins(left: 5, top: 2, right: 5, bottom: 2)
            var flowPanel = MSBPageFlowPanel(rect: MSBPageRect(x: 15, y: 0, width: 230, height: 105))
            flowPanel.addElements([textBlock, button])
            var pageLayout = MSBPageLayout(root: flowPanel)
            tile.pageLayouts.addObject(pageLayout)
            self.client.tileManager.addTile(tile, completionHandler: { (error) -> Void in
                if error == nil || error.localizedDescription == "Tile already exists." {
                    self.output("Creating page...")
                    var pageID = NSUUID(UUIDString: "1234BA9F-12FD-47A5-83A9-E7270A43BB99")!
                    var pageValues = [
                        MSBPageTextButtonData(elementId: 11, text: "Press Me", error: nil),
                        MSBPageTextBlockData(elementId: 10, text: "TextButton Sample", error: nil)
                    ]
                    //var pageValues:NSArray = [
                    //    [MSBPageTextButtonData(elementId: 11, text: "Press Me", error: nil)],
                    //    [MSBPageTextBlockData(elementId: 10, text: "TextButton Sample", error: nil)]
                    //]
                    var pageData = MSBPageData(id: pageID, layoutIndex: 0, value: pageValues)
                    self.client.tileManager.setPages([pageData], tileId: tileID, completionHandler: { (error) -> Void in
                        if error == nil {
                            self.output("Successfully Finished!!!")
                            self.output("You can press the button on the 'button' Tile to observe Tile Event,")
                            self.output("or remove the tile via Microsoft Health App.")
                        } else {
                            self.output(error.localizedDescription)
                            println(error)
                        }
                    })
                    
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
            client.tileDelegate = self
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

    // MSBClientManagerDelegate
    
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
        var current = self.txtOutlet.text
        self.txtOutlet.text = current+"\n"+string
    }
    
    // MSBClientTileDelegate Methods

    func client(client: MSBClient!, tileDidOpen event: MSBTileEvent!) {
        self.output("\(event)")
    }
    
    func client(client: MSBClient!, buttonDidPress event: MSBTileButtonEvent!) {
        self.output("\(event)")
    }
    
    func client(client: MSBClient!, tileDidClose event: MSBTileEvent!) {
        self.output("\(event)")
    }
    
}

