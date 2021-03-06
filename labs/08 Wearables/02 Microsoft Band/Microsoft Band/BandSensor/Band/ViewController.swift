//
//  ViewController.swift
//  Band
//
//  Created by Mark Tyers on 22/06/2015.
//  Copyright (c) 2015 Coventry University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MSBClientManagerDelegate {
    
    var client:MSBClient!

    @IBOutlet weak var accelLabel: UILabel!
    
    @IBAction func runExampleCode(sender: UIButton) {
        if (self.client.isDeviceConnected) {
            print("Starting Accelerometer updates...")
            self.client.sensorManager.startAccelerometerUpdatesToQueue(nil, errorRef: nil, withHandler: {(accelerometerData, error) -> (Void) in
                self.accelLabel.text = "x:\(accelerometerData.x)  y:\(accelerometerData.y)  z:\(accelerometerData.z)"
            })
        }
    }
    
    // <#((MSBSensorAccelerometerData!, NSError!) -> Void)!##(MSBSensorAccelerometerData!, NSError!) -> Void#>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MSBClientManager.sharedManager().delegate = self
        var clients = MSBClientManager.sharedManager().attachedClients()
        if let _client:MSBClient = clients[0] as? MSBClient {
            client = _client
            MSBClientManager.sharedManager().connectClient(client)
            print("Please wait. Connecting to Band...")
        } else {
            print("Failed! No Bands attached.")
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Client Manager Delegates
    
    func clientManager(clientManager: MSBClientManager!, clientDidConnect client: MSBClient!) {
        print("Band connected.")
    }
    
    func clientManager(clientManager: MSBClientManager!, clientDidDisconnect client: MSBClient!) {
        print("Band disconnected.")
    }
    
    func clientManager(clientManager: MSBClientManager!, client: MSBClient!, didFailToConnectWithError error: NSError!) {
        print("Failed to connect to Band.")
        print(error.description)
    }

}

