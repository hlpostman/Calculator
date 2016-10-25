//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Aristotle on 2016-10-15.
//  Copyright © 2016 Aristotle. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0
    func setOperand (operand: Double) {
        accumulator = operand
    }

    private var operations: [String: Operation] = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "±" : Operation.UnaryOperation({-$0}),
//        "θ" : Operation.UnaryOperation(),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "tan" : Operation.UnaryOperation(tan),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "^" : Operation.BinaryOperation(pow),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation (symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator )
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(function: function, firstOperand: accumulator)
            case .Equals :
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.function(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var function: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
           return accumulator
        }
    }
}
