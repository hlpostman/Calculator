//
//  ViewController.swift
//  Calculator
//
//  Created by Aristotle on 2016-10-15.
//  Copyright © 2016 Aristotle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsinTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsinTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
            display.textColor = sender.backgroundColor
            
        } else {
            display.text = digit
            display.textColor = sender.backgroundColor
        }
        userIsinTheMiddleOfTyping = true
    }
    
    @IBAction private func touchWatermelon(_ sender: UIButton) {
        let watermelon = sender.currentTitle!
        let textCurrentlyInDisplay = display.text!
        display.text = watermelon
      
        userIsinTheMiddleOfTyping = true
    }

    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            
            display.text! = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsinTheMiddleOfTyping {
            brain.setOperand(operand: Double(displayValue))
            userIsinTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
            }
        display.textColor = sender.backgroundColor
        displayValue = brain.result
    }
    // Reset calculation upon shake:
    // User starts moving phone
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake {
            print("\(motion) \(event)")
        }
    }

    // User stops moving phone
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake {
            display.text = ""
            brain.setOperand(operand: 0.0)
            brain.pending?.firstOperand = 0.0
            userIsinTheMiddleOfTyping = false
        }
    }
}


 
