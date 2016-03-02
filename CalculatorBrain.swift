//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Angelo Wong on 2/26/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        case ClearOperation(String)
        case PiOperation(String)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _ ):
                    return symbol
                case .ClearOperation(let symbol):
                    return symbol
                case .PiOperation(let symbol):
                    return symbol
                }
            }
        }
    }
    
    var opHistory = ""
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷") { $1 / $0 })
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("-") { $1 - $0 })
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
        learnOp(Op.UnaryOperation("ᐩ/-", -))
        learnOp(Op.ClearOperation("C"))
        learnOp(Op.PiOperation("π"))
    }
    
    //pass back and forth the program operation stack
    typealias PropertyList = AnyObject
    
    var program: PropertyList { //guaranteed to be a PropertyList
        get {
            return opStack.map{ $0.description }
        }
        set {
            if let opSymbols = newValue as? Array<String> {
                var newOpStack = [Op]()
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue {
                        newOpStack.append(.Operand(operand))
                    }
                }
                opStack = newOpStack
            }
        }
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op], opHistory: String) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps, "\(operand)")
            case .UnaryOperation(let symbol, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    opHistory = "\(symbol)(\(operandEvaluation.opHistory))"
                    return (operation(operand), operandEvaluation.remainingOps, opHistory)
                }
            case .BinaryOperation(let symbol, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        print("op1: \(operand1); op2: \(operand2)")
                        if symbol == "-" || symbol == "÷" {
                            opHistory = "(\(op2Evaluation.opHistory) \(symbol) \(operand1))"
                        } else {
                            opHistory = "(\(operand1) \(symbol) \(op2Evaluation.opHistory))"
                        }

                        return (operation(operand1, operand2), op2Evaluation.remainingOps, opHistory)
                    }
                }
            case .ClearOperation(_):
                opStack = []
                opHistory = ""
                return (0, [], opHistory)
            case .PiOperation(_):
                return (M_PI, remainingOps, "π") //no .removeLast() since we need to wait for an operation to operate on pi
            }
        }
        return (nil, ops, "")
    }
    
    func evaluate() -> Double? {
        let (result, remainder, _) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double?) -> Double? {
        if let validOperand = operand {
            opStack.append(Op.Operand(validOperand))
        }
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func printOpHistory() -> String {
        return opHistory
    }
    
}