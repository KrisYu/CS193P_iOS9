//
//  ViewController.swift
//  Calculater_l1
//
//  Created by 雪 禹 on 5/14/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var formula: UILabel!
    
    
    var userIsInTheMiddleOfTyping = false
    
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
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        
    }
    
    @IBAction func clearButton(sender: UIButton) {
        display.text = String(0)
        formula.text = " "
        brain.setOperand(0)
        userIsInTheMiddleOfTyping = false
    }
    
    

}

