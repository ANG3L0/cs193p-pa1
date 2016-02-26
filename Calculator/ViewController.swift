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
    
    let errmsg = "N/A (please clear)"
    var userIsInTheMiddleOfTypingANumber = false
    var operandStack = Array<Double>()
    var freeze = false

    @IBAction func appendDigit(sender: UIButton) {
        if freeze { return }
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

    @IBAction func valueManip(sender: UIButton) {
        if freeze { return }
        let manipulator = sender.currentTitle!
        switch manipulator {
        case "⌫":
            delDispLastChar()
            if display.text!.isEmpty {
                display.text! = "0"
                userIsInTheMiddleOfTypingANumber = false //erased to 0, don't want to have "03" in display
            } else {
                userIsInTheMiddleOfTypingANumber = true
            }
        case "ᐩ/-":
            let startIdx = display.text!.startIndex
            if (!display.text!.isEmpty) {
                if (display.text![startIdx] != "-") {
                    display.text!.insert("-", atIndex: startIdx)
                } else {
                    display.text!.removeAtIndex(startIdx)
                }
                
            }
            
        default: break
        }
    }
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if freeze && operation != "C" { return }
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
            resetCalc()
            freeze = false
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
            appendDispEquals()
        }
    }
    private func performOperation(opSymbol: String, operation: Double -> Double) {
        if operandStack.count >= 1 {
            let op1 = operandStack.removeLast()
            displayValue = operation(op1)
            opHistory.text! += "<\(opSymbol)\(op1)> "
            enter() //after last 2 operands done, want to work on next op, example: "6 ent 3 ent times 9 plus"
            appendDispEquals()
        }
    }

    
    
    
    @IBAction func enter() {
        if freeze { return }
        userIsInTheMiddleOfTypingANumber = false
        if let dispValid = displayValue {
            operandStack.append(dispValid)
        } else {
            //N/A situation, clear everything out
            operandStack = []
        }
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double? {
        get {
            if display.text!.characters.last == "=" {
                delDispLastChar()
            }
            if let strNumber = NSNumberFormatter().numberFromString(display.text!) {
                return strNumber.doubleValue
            } else {
                //special case of PI and the spec to clear the display if N/A
                if (display.text! != "π") {
                    display.text = errmsg
                    freeze = true
                    resetCalc()
                    return 0
                }
                return M_PI
            }
        }
        set {
            display.text = newValue == M_PI ? "π" : "\(newValue!)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    private func delDispLastChar() {
        display.text! = String(display.text!.characters.dropLast())
    }
    private func appendDispEquals() {
        if (display.text!.characters.last != "=" && display.text! != errmsg) {
            display.text! += "="
        }
    }
    private func resetCalc() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack = []
        opHistory.text! = ""
    }
}

