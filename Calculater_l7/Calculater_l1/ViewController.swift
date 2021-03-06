//
//  ViewController.swift
//  Calculater_l1
//
//  Created by 雪 禹 on 5/14/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

var calculatorCount = 0

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    private var userIsInTheMiddleOfTyping = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorCount += 1
        print("Loaded up a new Calculator (count = \(calculatorCount))")
        
        brain.addUnaryOperation("Z"){ [unowned me = self] in
            me.display.textColor = UIColor.redColor()
            return sqrt($0)
        }
    }
    
    deinit {
        calculatorCount -= 1
        print("Calculator left the heap (count = \(calculatorCount))")
    }
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentIndisplay = display.text! + digit
            display.text = textCurrentIndisplay
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    // computed property
    private var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    
    var savedProgram : CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    
    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    
    
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    

}

