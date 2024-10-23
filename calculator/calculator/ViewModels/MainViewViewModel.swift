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
    @Published var showingView = false
    
    func count() {
        
        var first = firstNumber
        var second = secondNumber
        
        if first.contains(",") {
            first = first.replacingOccurrences(of: ",", with: ".")
        }
        
        if second.contains(",") {
            second = second.replacingOccurrences(of: ",", with: ".")
        }
        
        let firstNumber = NSDecimalNumber(string: first)
        let secondNumber = NSDecimalNumber(string: second)
        
        
        if firstNumber == NSDecimalNumber.notANumber || secondNumber == NSDecimalNumber.notANumber {
            result = "You can enter only numbers"
            return
        }
        
        let resultDecimal = selection == 0 ? plus(first: firstNumber, second: secondNumber) : minus(first: firstNumber, second: secondNumber)
        result = resultDecimal.stringValue
    }
    
    func plus(first: NSDecimalNumber, second: NSDecimalNumber) -> NSDecimalNumber {
        return first.adding(second)
    }
    
    func minus(first: NSDecimalNumber, second: NSDecimalNumber) -> NSDecimalNumber {
        return first.subtracting(second)
    }
    
    func tapInfo() {
        showingView = true
    }
}
