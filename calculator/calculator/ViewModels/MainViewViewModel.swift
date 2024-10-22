//
//  MainViewViewModel.swift
//  calculator
//
//  Created by Victoria Samsonova on 21.10.24.
//

import Foundation
import UIKit

class MainViewViewModel: ObservableObject {
    
    @Published var result = ""
    @Published var firstNumber = ""
    @Published var secondNumber = ""
    @Published var selection = 0
    
    @Published var flag = true
    
    func count() {
        guard let firstNumber = Decimal(string: firstNumber), let secondNumber = Decimal(string: secondNumber) else {
            result = "You can enter only numbers"
            return
        }
        
        var resultDecimal = selection == 0 ? plus(first: firstNumber, second: secondNumber) : minus(first: firstNumber, second: secondNumber)
        result = NSDecimalString(&resultDecimal, nil)
    }
    
    func plus(first: Decimal, second: Decimal) -> Decimal {
        return first + second
    }
    
    func minus(first: Decimal, second: Decimal) -> Decimal {
        return first - second
    }
}
