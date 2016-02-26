//
//  ViewController.swift
//  Calculator
//
//  Created by Angelo Wong on 2/22/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel! //implicit unwrapped optional
    @IBOutlet weak var opHistory: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var operandStack = Array<Double>()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        let dupDecimal = decimalDupCheck(digit, display.text)
        if userIsInTheMiddleOfTypingANumber {
            if !dupDecimal {
                display.text = display.text! + digit
            }
        } else {
            display.text = digit == "." ? "0" + digit : digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    func decimalDupCheck(digit: String, _ text: String?) -> Bool {
        if userIsInTheMiddleOfTypingANumber {
            return digit == "." && text?.containsString(".") == true
        } else {
            return false
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter() //add to stack if say "6 enter 3 times"
        }
        switch operation {
        case "×": performOperation("×") { $0 * $1 }
        case "÷": performOperation("÷") { $1 / $0 }
        case "+": performOperation("+") { $0 + $1 }
        case "-": performOperation("-") { $0 - $1 }
        case "√": performOperation("√") { sqrt($0) }
        case "sin": performOperation("SIN ") { sin($0) }
        case "cos": performOperation("COS ") { cos($0) }
        case "π":
            displayValue = M_PI
            enter()
        case "C":
            userIsInTheMiddleOfTypingANumber = false
            operandStack = []
            opHistory.text! = ""
            displayValue = 0
        default: break
        }
        

    }
    
    private func performOperation(opSymbol: String, operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            let op1 = operandStack.removeLast()
            let op2 = operandStack.removeLast()
            displayValue = operation(op1, op2)
            opHistory.text! += opSymbol == "÷" ? "<\(op2) \(opSymbol) \(op1)> ": "<\(op1) \(opSymbol) \(op2)> "
            enter() //after last 2 operands done, want to work on next op, example: "6 ent 3 ent times 9 plus"
        }
    }
    private func performOperation(opSymbol: String, operation: Double -> Double) {
        if operandStack.count >= 1 {
            let op1 = operandStack.removeLast()
            displayValue = operation(op1)
            opHistory.text! += "<\(opSymbol)\(op1)> "
            enter() //after last 2 operands done, want to work on next op, example: "6 ent 3 ent times 9 plus"
        }
    }

    
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return display.text! == "π" ? M_PI : NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = newValue == M_PI ? "π" : "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

