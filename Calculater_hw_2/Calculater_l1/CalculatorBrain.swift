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
    private var internalProgram = [AnyObject]()
    
    var variableValues = [String:Double]()
    
    var description = " "
    var isPartialResult = false
    
    typealias PropertyList = AnyObject
    
    var program : PropertyList {
        get {
            return internalProgram
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject]{
                for op in arrayOfOps {
                    if let operand = op as? Double{
                        setOperand(operand)
                    } else if let operation = op as? String{
                        performOperation(operation)
                    }
                }
            }
        }
    }
    
    

    func setOperand(operand: Double){
        accumulator = operand
        internalProgram.append(operand)
        if isPartialResult == false {
            description = String(format: "%g",accumulator)
        }
    }
    
    func setOperand(variableName: String) {
        
    }
    

    
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "tan" : Operation.UnaryOperation(tan),
        "ln" : Operation.UnaryOperation(log),
        "1/x" : Operation.UnaryOperation({1.0/$0}),
        "x^2" : Operation.UnaryOperation({$0*$0}),
        "Rand" : Operation.Random,
        "%" : Operation.BinaryOperation({$0 % $1}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals,
        "c" : Operation.Clear,
        "→m": Operation.Variable
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Random
        case Equals
        case Clear
        case Variable
    }
    
    
    func performOperation(symbol : String){
        internalProgram.append(symbol)
        //API incase that symbol doesnot exit in dictionary
        if let operation = operations[symbol]{
            switch operation {
            case .Constant (let value):
                accumulator = value
                if isPartialResult == true {
                    description += symbol
                    isPartialResult = false
                } else {
                    description = symbol
                }
            case .UnaryOperation (let function) :
                accumulator = function(accumulator)
                if isPartialResult == true {
                    description += symbol + String(format: "%g",accumulator)
                    isPartialResult = false
                } else {
                    description = symbol + "(\(description))"
                }
            case .BinaryOperation (let function) :
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
                description += " " + symbol + " "
                isPartialResult = true
            case .Random :
                srand48(Int(arc4random()))
                accumulator = drand48()
                if isPartialResult == true {
                    description += symbol
                    isPartialResult = false
                } else {
                    description = symbol
                }
            case .Equals :
                executePendingBinaryOperation()
            case .Clear:
                clear()
            case .Variable:
                if isPartialResult == true {
                    description += "m"
                    isPartialResult = false
                } else {
                    description = "m"
                }
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if  isPartialResult == true {
            description += String(format: "%g",accumulator)
            isPartialResult = false
        }
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    

    
    
    private func clear(){
        accumulator = 0.0
        pending = nil
        isPartialResult = false
        description = " "
        variableValues.removeAll()
    }
    
    
    private var pending: PendingBinaryOperationInfo?
    
    
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
