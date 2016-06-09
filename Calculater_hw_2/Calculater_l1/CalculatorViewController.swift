//
//  ViewController.swift
//  Calculater_l1
//
//  Created by 雪 禹 on 5/14/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var formula: UILabel!
    
    private var brain = CalculatorBrain()
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            var textCurrentIndisplay = display.text! + digit
            if let pos = textCurrentIndisplay.rangeOfString("."){
                textCurrentIndisplay = textCurrentIndisplay.stringByReplacingOccurrencesOfString(".", withString: "", options: NSStringCompareOptions.LiteralSearch, range: pos.endIndex..<textCurrentIndisplay.endIndex)
            }
            display.text = textCurrentIndisplay
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
        
    }
    
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    

    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    
    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    
    @IBAction func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        
        formula.text = brain.description
        if formula.text == " " {return}
        if brain.isPartialResult == true {
            formula.text! += "..."
        } else {
            formula.text! += " ="
        }
        
        print(brain.description)
    }
    
    
    @IBAction func setVaraible(sender: UIButton) {
        brain.variableValues["m"] = displayValue
        displayValue = brain.result
    }
    
    
    
    

}

