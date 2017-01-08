//
//  ViewController.swift
//  Prim2
//
//  Created by Marius Ilie on 08/01/17.
//  Copyright © 2017 University of Bucharest - Marius Ilie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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

    @IBAction func onButtonTap(_ sender: UIButton) {
        if let textFieldContent = textField.text {
            number = Int(textFieldContent)
        }
    }
    
    @IBAction func changeNumber(_ sender: UIButton) {
        if let currentTitle = sender.currentTitle {
            number = Int(currentTitle)
        }
    }
}

