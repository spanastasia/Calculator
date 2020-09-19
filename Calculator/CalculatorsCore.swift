//
//  CalculatorsCore.swift
//  Calculator
//
//  Created by Anastasiia Spiridonova on 16.09.2020.
//  Copyright © 2020 Anastasiia Spiridonova. All rights reserved.
//

import Foundation

struct CalculatorCore {
    
    private var accamulator: Double? = 0
    private var buffer = 0.0
    private var pendingBinaryOperation: PendingBinaryOperation?
    private let operations = OperationDictionary.operations
    
    private mutating func performPendingBinaryOperation() {
           if pendingBinaryOperation != nil && accamulator != nil {
               accamulator = pendingBinaryOperation!.perform(with: accamulator!)
               pendingBinaryOperation = nil
           }
       }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accamulator = value
            case .random(let function):
                accamulator = function()
            case .unaryOperation(let function):
                if accamulator != nil {
                    accamulator = function(accamulator!)
                }
            case .binaryOperation(let function):
                if accamulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accamulator!)
                    accamulator = nil
                }
            case .clear:
                accamulator = 0
                pendingBinaryOperation = nil
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    
    
    mutating func setOperand(_ operand: Double) {
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
    
}
