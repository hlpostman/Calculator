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
    private func clearCurrentTextAndCalculation(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            display.text = ""
            brain.setOperand(operand: 0.0)
            userIsinTheMiddleOfTyping = false
        }
    }
}


 
