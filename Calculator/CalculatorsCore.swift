//
//  CalculatorsCore.swift
//  Calculator
//
//  Created by Anastasiia Spiridonova on 16.09.2020.
//  Copyright © 2020 Anastasiia Spiridonova. All rights reserved.
//

import Foundation

class CalculatorCore {
    
    private var accamulator: Double? = 0
    private var buffer = 0.0
    private var pendingBinaryOperation: PendingBinaryOperation?
    private let operations = OperationDictionary.operations
    private var units = Units.degrees
    
    private func performPendingBinaryOperation() {
           if pendingBinaryOperation != nil && accamulator != nil {
               accamulator = pendingBinaryOperation!.perform(with: accamulator!)
               pendingBinaryOperation = nil
           }
       }
    
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accamulator = value
            case .random(let function):
                accamulator = function()
            case .unaryOperation(let function):
                if let accamulator = accamulator {
                    self.accamulator = function(accamulator)
                }
            case .binaryOperation(let function):
                if let accamulator = accamulator {
                    if pendingBinaryOperation != nil {
                        performPendingBinaryOperation()
                    }
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accamulator)
                }
            case .clear:
                accamulator = 0
                pendingBinaryOperation = nil
            case .equals:
                performPendingBinaryOperation()
            case .trigonometryFunction(let function):
                if let accamulator = accamulator {
                    switch units {
                    case .degrees:
                        self.accamulator = function(accamulator * Double.pi / 180)
                    case .radians:
                        self.accamulator = function(accamulator)
                    }
                }
            }
        }
    }
    
    
    
    func setOperand(_ operand: Double) {
        accamulator = operand
    }
    
    
    var resault: Double? {
        get {
            return accamulator
        }
    }
    var bufferValue: Double {
        get {
            return buffer
        }
        set {
            buffer = newValue
        }
    }
    
    var unitsValue: Units {
        get {
            return units
        }
        set {
            units = newValue
        }
    }
    
}
