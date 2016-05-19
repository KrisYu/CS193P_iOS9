//
//  CalculatorBrain.swift
//  Calculater_hw_1
//
//  Created by 雪 禹 on 5/16/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "ln" : Operation.UnaryOperation(log),
        "Rand" : Operation.Random,
        "%" : Operation.BinaryOperation({$0 % $1}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Random
        case Equals
    }
    
    
    func performOperation(symbol : String){
        //API incase that symbol doesnot exit in dictionary
        if let operation = operations[symbol]{
            switch operation {
            case .Constant (let value):
                accumulator = value

            case .UnaryOperation (let function) :
                accumulator = function(accumulator)
            case .BinaryOperation (let function) :
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Random :
                srand48(Int(arc4random()))
                accumulator = drand48()
            case .Equals :
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    //the sequence of operands and operations that led to the value returned by result
    var description: String = ""
    var isPartialResult: Bool = false
    

    
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction : (Double,Double) -> Double
        var firstOperand : Double
    }
    
    var result : Double{
        get {
            return accumulator
        }
    }
}
