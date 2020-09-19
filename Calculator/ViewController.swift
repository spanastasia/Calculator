//
//  ViewController.swift
//  Calculator
//
//  Created by Anastasiia Spiridonova on 11.09.2020.
//  Copyright © 2020 Anastasiia Spiridonova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var display: UILabel!
    @IBOutlet var alternativeFunctions: [UIButton]!
    @IBOutlet var basicFunctions: [UIButton]!
    var userIsTyping = false
    private var core = CalculatorCore()
    private let POINT = "."
    private let EXP: Character = "e"
    private let MINUS: Character = "-"
    private let PLUS: Character = "+"
    
    
    private func addToDisplay(symbol: String) {
        if !display.text!.contains(symbol) {
            userIsTyping = true
            display.text = display.text! + symbol
        }
    }
    
    var displayValue: Double {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            if let number = formatter.number(from: display.text!) {
                return Double(truncating: number)
            }
            return 0.0
            
        }
        set {
            display.text = String(format: "%g", newValue)
        }
    }
    
    
    @IBAction func touchChangeSign() {
        var text = display.text!
        if text.contains(EXP) {
            let index = text.index(after: text.lastIndex(of: EXP)!)
            let textBeforeE = text.prefix(upTo: index)
            var textAfterE = text.suffix(from: index)
            guard textAfterE.count > 0 else {
                text.append(MINUS)
                display.text = text
                return
            }
            if (textAfterE.contains(MINUS)) {
                textAfterE.removeFirst()
                display.text = String(textBeforeE) + String(textAfterE)
            } else if (textAfterE.contains(PLUS)) {
                textAfterE.removeFirst()
                display.text = String(textBeforeE) + String(MINUS) + String(textAfterE)
            } else {
                display.text = String(textBeforeE) + String(MINUS) + String(textAfterE)
            }
        } else {
            displayValue = -displayValue
        }
    }
    
    @IBAction func touchPoint() {
        addToDisplay(symbol: POINT)
    }
    
    @IBAction func touchEE() {
        addToDisplay(symbol: String(EXP))
    }
    
    @IBAction func touchTwoND() {
        if basicFunctions.randomElement()!.isHidden {
            basicFunctions.forEach(showBtn(btn:))
            alternativeFunctions.forEach(hideBtn(btn:))
        } else {
            basicFunctions.forEach(hideBtn(btn:))
            alternativeFunctions.forEach(showBtn(btn:))
        }
    }
    
    @IBAction func touchMemoryAction(_ sender: UIButton) {
        var title = sender.currentTitle!
        if title.removeLast() == Character("c") {
            core.bufferValue = 0
        } else {
             displayValue = core.bufferValue
        }
    }
    
    @IBAction func touchMemoryArytmeticOperation(_ sender: UIButton) {
        var title = sender.currentTitle!
        if title.removeLast() == MINUS {
            displayValue = displayValue - core.bufferValue
        } else {
            displayValue = displayValue + core.bufferValue
        }
        core.bufferValue = displayValue
    }
    
    
    
    @IBAction func touchDidits(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping && displayValue != 0 {
            let currentOnDisplay = display.text!
            if currentOnDisplay.count < 16 {
                display.text = currentOnDisplay + digit
            }
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            core.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            core.performOperation(mathematicalSymbol)
        }
        if let resault = core.resault {
            displayValue = resault
        }
    }
    
    private func hideBtn(btn: UIButton) {
        btn.isHidden = true
    }
    private func showBtn(btn: UIButton) {
        btn.isHidden = false
    }
    
}

