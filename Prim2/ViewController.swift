//
//  ViewController.swift
//  Prim2
//
//  Created by Marius Ilie on 08/01/17.
//  Copyright © 2017 University of Bucharest - Marius Ilie. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    // needed methods from
    // WCSessionDelegate Protocol
    
    var watchSession: WCSession?
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    // stop methods from
    // WCSession
    
    var number: Int? {
        didSet {
            if number != nil {
                textField.text = String(describing: number!)
                isPrime = check(prime: number)
            } else {
                textField.text = nil
                statusLabel.text = "PRIM APP"
                view.backgroundColor = UIColor.white
            }
        }
    }
    
    var isPrime = false {
        didSet {
            if isPrime == false {
                statusLabel.text = "NEPRIM"
                view.backgroundColor = UIColor.red
            } else {
                statusLabel.text = "PRIM"
                view.backgroundColor = UIColor.green
            }
            
            // WCSession
            try? watchSession?.updateApplicationContext(["isPrime" : isPrime])
        }
    }
    
    func check(prime number: Int!) -> Bool {
        if number <= 1 {
            return false
        } else if number <= 3{
            return true
        }
        
        for i in 2...(number-1) {
            if number % i == 0 {
                return false
            }
        }
            
        return true
    }

    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var textField: UITextField!
    
    func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard))
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // apple watch
        // WCSession
        
        if(WCSession.isSupported()){
            watchSession = WCSession.default()
            watchSession!.delegate = self
            watchSession!.activate()
        }
    }
    
    @IBAction func onButtonTap(_ sender: AnyObject) {
        if let textFieldContent = textField.text {
            number = Int(textFieldContent)
        }
    }
    
    @IBAction func setNumberWith(_ sender: UIButton) {
        if let titleContent = sender.currentTitle {
            number = Int(titleContent)
        }
    }
}

