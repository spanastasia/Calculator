//
//  TwoNdBtn.swift
//  Calculator
//
//  Created by Anastasiia Spiridonova on 15.09.2020.
//  Copyright © 2020 Anastasiia Spiridonova. All rights reserved.
//

import Foundation
import UIKit

public class TwoNdBtn {
    var touched: Bool
    
    func touch() -> Void {
        touched = (touched == true ? false : true)
    }
    
    init() {
        touched = false
    }
}
