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
    @IBOutlet var trigonometryFunctions: [UIButton]!
    @IBOutlet weak var unitsBtn: UIButton!
    
    
    
    var userIsTyping = false
    private var core = CalculatorCore()
    private let kPoint = "."
    private let kExp: Character = "e"
    private let kMinus: Character = "-"
    private let kPlus: Character = "+"
    
    
    private func addToDisplay(symbol: String) {
        guard let text = display.text else { return }
        if !text.contains(symbol) {
            userIsTyping = true
            display.text = text + symbol
        }
    }
    
    var displayValue: Double {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            guard let text = display.text else {
                return 0.0
            }
            if let number = formatter.number(from: text) {
                return Double(truncating: number)
            }
            return 0.0
            
        }
        set {
            display.text = String(format: "%g", newValue)
        }
    }
    @IBAction func changeUnits(_ sender: UIButton) {
        switch core.unitsValue {
        case .degrees:
            sender.setTitle(core.unitsValue.rawValue, for: UIControl.State.normal)
            core.unitsValue = Units.radians
        case .radians:
            sender.setTitle(core.unitsValue.rawValue, for: UIControl.State.normal)
            core.unitsValue = Units.degrees
        }
    }
    
    @IBAction func touchChangeSign() {
        guard display.text != nil else { return }
        var text = display.text!
        if text.contains(kExp) {
            let index = text.index(after: text.lastIndex(of: kExp)!)
            let textBeforeE = text.prefix(upTo: index)
            var textAfterE = text.suffix(from: index)
            guard textAfterE.count > 0 else {
                text.append(kMinus)
                display.text = text
                return
            }
            if (textAfterE.contains(kMinus)) {
                textAfterE.removeFirst()
                display.text = String(textBeforeE) + String(textAfterE)
            } else if (textAfterE.contains(kPlus)) {
                textAfterE.removeFirst()
                display.text = String(textBeforeE) + String(kMinus) + String(textAfterE)
            } else {
                display.text = String(textBeforeE) + String(kMinus) + String(textAfterE)
            }
        } else {
            if text != "0" {
                displayValue = -displayValue
            }
        }
    }
    
    @IBAction func touchSeparator(_ sender: UIButton) {
        var separator: String
        if sender.currentTitle == kPoint {
            separator = kPoint
        } else {
            separator = String(kExp)
            print(kExp)
        }
        addToDisplay(symbol: separator)
    }
    
    
    @IBAction func touchTwoND() {
        if basicFunctions.first!.isHidden {
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
        if title.removeLast() == kMinus {
            displayValue = displayValue - core.bufferValue
        } else {
            displayValue = displayValue + core.bufferValue
        }
        core.bufferValue = displayValue
    }
    
    
    
    @IBAction func touchDidits(_ sender: UIButton) {
        guard let digit = sender.currentTitle, let currentOnDisplay = display.text else { return }
        if userIsTyping,
           currentOnDisplay != "0",
           currentOnDisplay.count < 16
        {
            display.text = currentOnDisplay + digit
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch core.unitsValue {
        case .degrees:
            unitsBtn.setTitle(Units.radians.rawValue, for: UIControl.State.normal)
        case .radians:
            unitsBtn.setTitle(Units.degrees.rawValue, for: UIControl.State.normal)
        }
        alternativeFunctions.forEach(hideBtn)
        if Double(view.bounds.width) > Double(view.bounds.height) {
            basicFunctions.forEach(showBtn)
        } else {
            basicFunctions.forEach(hideBtn)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Double(view.bounds.width) >= Double(view.bounds.height) || Double(view.bounds.width) > 600 {
            if basicFunctions.first!.isHidden == alternativeFunctions.first!.isHidden {
                basicFunctions.forEach(showBtn)
                alternativeFunctions.forEach(hideBtn)
            }
        } else {
            if !basicFunctions.first!.isHidden, !alternativeFunctions.first!.isHidden {
                basicFunctions.forEach(hideBtn)
                alternativeFunctions.forEach(hideBtn)
            }
        }
    }
}

