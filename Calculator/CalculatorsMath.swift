//
//  CalculatorsMath.swift
//  Calculator
//
//  Created by Anastasiia Spiridonova on 17.09.2020.
//  Copyright © 2020 Anastasiia Spiridonova. All rights reserved.
//

import Foundation

public enum Operation {
    case constant(Double)
    case unaryOperation((Double) -> Double)
    case trigonometryFunction((Double) -> Double)
    case binaryOperation((Double, Double) -> Double)
    case clear
    case random(() -> Double)
    case equals
}

public enum Units: String {
    case degrees = "Deg"
    case radians = "Rad"
}

public class OperationDictionary {
    public static let operations: Dictionary<String, Operation> = [
        "C" : Operation.clear,
        "%" : Operation.binaryOperation({ $0 / 100.0 * $1 }),
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "x²" : Operation.unaryOperation({ pow($0, 2.0) }),
        "x³" : Operation.unaryOperation({ pow($0, 3.0) }),
        "xʸ" : Operation.binaryOperation(pow),
        "eˣ" : Operation.unaryOperation(exp),
        "10ˣ" : Operation.unaryOperation({ pow(10.0, $0) }),
        "yˣ" : Operation.binaryOperation({ pow($1, $0) }),
        "2ˣ" : Operation.unaryOperation({ pow(2.0, $0) }),
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "1/x" : Operation.unaryOperation({ 1.0 / $0 }),
        "²√x" : Operation.unaryOperation(sqrt),
        "³√x" : Operation.unaryOperation({ pow( $0, (1.0 / 3.0)) }),
        "ˣ√y" : Operation.binaryOperation({ pow($1, (1.0 / $0)) }),
        "ln" : Operation.unaryOperation(log),
        "logₓy" : Operation.binaryOperation({ log($1) / log($0) }),
        "log₁₀" : Operation.unaryOperation(log10),
        "log₂" : Operation.unaryOperation(log2),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "x!" : Operation.unaryOperation(factorial),
        "sin" : Operation.trigonometryFunction(sin),
        "sin⁻¹" : Operation.trigonometryFunction({ 1.0 / sin($0) }),
        "cos" : Operation.trigonometryFunction(cos),
        "cos⁻¹" : Operation.trigonometryFunction({ 1.0 / cos($0) }),
        "tan" : Operation.trigonometryFunction(tan),
        "tan⁻¹": Operation.trigonometryFunction({ 1.0 / tan($0) }),
        "e" : Operation.constant(M_E),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "sinh" : Operation.trigonometryFunction(sinh),
        "sinh⁻¹" : Operation.trigonometryFunction({ 1.0 / sinh($0) }),
        "cosh" : Operation.trigonometryFunction(cosh),
        "cosh⁻¹" : Operation.trigonometryFunction({ 1.0 / cos($0)} ),
        "tanh" : Operation.trigonometryFunction(tanh),
        "tanh⁻¹" : Operation.trigonometryFunction({ 1.0 / tanh($0) }),
        "𝜋" : Operation.constant(Double.pi),
        "Rand" : Operation.random(random),
        "=" : Operation.equals
    ]
    
    public static func factorial(_ number: Double) -> Double {
        let value = Int(number)
        guard Double(number) - number == 0 else {
            return number
        }
        if value == 1 || value == 0 {
            return 1
        }
        return Double(value) * factorial(Double(value - 1))
    }
    
    public static func random() -> Double {
        return Double.random(in: 0..<1)
    }
}

public struct PendingBinaryOperation {
    let function: (Double, Double) -> Double
    let firstOperand: Double
    
    func perform(with secondOperand: Double) -> Double {
        return function(firstOperand, secondOperand)
    }
}




