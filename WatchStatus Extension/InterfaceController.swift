//
//  InterfaceController.swift
//  WatchStatus Extension
//
//  Created by Marius Ilie on 09/01/17.
//  Copyright © 2017 University of Bucharest - Marius Ilie. All rights reserved.
//

import WatchKit
import WatchConnectivity

import Foundation


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // needed methods from
    // WCSessionDelegate Protocol
    
    var watchSession: WCSession?
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let isPrime: Bool = applicationContext["isPrime"] as? Bool {
            if isPrime {
                statusLabel.setText("PRIM")
                statusGroup.setBackgroundColor(UIColor.green)
            } else {
                statusLabel.setText("NEPRIM")
                statusGroup.setBackgroundColor(UIColor.red)
            }
        }
    }
    
    // stop methods from
    // WCSession
    
    
    @IBOutlet var statusGroup: WKInterfaceGroup!
    
    @IBOutlet var statusLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if(WCSession.isSupported()){
            watchSession = WCSession.default()
            watchSession!.delegate = self
            watchSession!.activate()
        }
    }

}
