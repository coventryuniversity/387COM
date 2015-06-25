//
//  ViewController.swift
//  BandCustomPages
//
//  Created by Mark Tyers on 23/06/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MSBClientManagerDelegate {

    var client:MSBClient!
    
    @IBOutlet weak var txtOutput: UITextView!
    
    @IBAction func runExampleCode(sender: UIButton) {
        if self.client.isDeviceConnected {
            self.output("Creating tile...")
            var tileName = "Barcode Tile"
            var tileID:NSUUID = NSUUID(UUIDString: "DCBABA9F-12FD-47A5-83A9-E7270A4399BB")!
            var tileIcon = MSBIcon(UIImage: UIImage(named: "A"), error: nil)
            var smallIcon = MSBIcon(UIImage: UIImage(named: "Aa"), error: nil)
            var tile:MSBTile = MSBTile(id: tileID, name: tileName, tileIcon: tileIcon, smallIcon: smallIcon, error: nil)
            var textBlock = MSBPageTextBlock(rect: MSBPageRect(x: 0, y: 0, width: 230, height: 40), font: MSBPageTextBlockFont.Small)
            textBlock.elementId = 10
            textBlock.baseline = 25
            textBlock.baselineAlignment = MSBPageTextBlockBaselineAlignment.Relative
            textBlock.horizontalAlignment = MSBPageHorizontalAlignment.Center
            textBlock.autoWidth = false
            var barcode = MSBPageBarcode(rect: MSBPageRect(x: 0, y: 0, width: 230, height: 95), barcodeType: MSBPageBarcodeType.CODE39)
            barcode.elementId = 11
            var flowPanel = MSBPageFlowPanel(rect: MSBPageRect(x: 15, y: 0, width: 260, height: 105))
            flowPanel.addElements([textBlock, barcode])
            var pageLayout = MSBPageLayout()
            pageLayout.root = flowPanel
            tile.pageLayouts.addObject(pageLayout)

            self.client.tileManager.addTile(tile, completionHandler: { (error) -> Void in
                if error == nil || error.localizedDescription == "Tile already exists." {
                    self.output("Creating page...")
                    var pageID = NSUUID(UUIDString: "1234BA9F-12FD-47A5-83A9-E7270A43BB99")!
                    var pageValues = [ MSBPageBarcodeData(elementId: 11, barcodeType: MSBPageBarcodeType.CODE39, value: "A1 B", error: nil),
                        MSBPageTextBlockData(elementId: 10, text: "Barcode value: A1 B", error: nil)
                    ]
                    var pageData = MSBPageData(id: pageID, layoutIndex: 0, value: pageValues)
                    self.client.tileManager.setPages([pageData], tileId: tileID, completionHandler: { (error) -> Void in
                        if error == nil {
                            self.output("Successfully Finished!!!")
                            self.output("or remove the tile via Microsoft Health App.")
                        } else {
                            self.output(error.localizedDescription)
                            println(error)
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

    
    // MSBClientManagerDelegate
    
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
        var current = self.txtOutput.text
        self.txtOutput.text = current+"\n"+string
    }
}

