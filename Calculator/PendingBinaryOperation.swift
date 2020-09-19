//
//  PendingBinaryOperation.swift
//  Calculator
//
//  Created by Anastasiia Spiridonova on 17.09.2020.
//  Copyright © 2020 Anastasiia Spiridonova. All rights reserved.
//

import Foundation

public struct PendingBinaryOperation {
    let function: (Double, Double) -> Double
    let firstOperand: Double
    
    func perform(with secondOperand: Double) -> Double {
        return function(firstOperand, secondOperand)
    }
}
