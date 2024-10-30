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
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        
        var first = firstNumber
        var second = secondNumber
        
        if first.contains(",") {
            first = first.replacingOccurrences(of: ",", with: ".")
        }
        
        if second.contains(",") {
            second = second.replacingOccurrences(of: ",", with: ".")
        }
        
        if first.lowercased().contains("e") || second.lowercased().contains("e") {
            result = "Экспоненциальная нотация не поддерживается"
        }
        
        let firstNumber = NSDecimalNumber(string: first)
        let secondNumber = NSDecimalNumber(string: second)
        
        
        if firstNumber == NSDecimalNumber.notANumber || secondNumber == NSDecimalNumber.notANumber {
            result = "You can enter only numbers"
            return
        }
        
        switch selection {
        case 0:
            let resultDecimal = plus(first: firstNumber, second: secondNumber)
            result = formatter.string(from: resultDecimal) ?? "Something went wrong"
        case 1:
            let resultDecimal = minus(first: firstNumber, second: secondNumber)
            result = formatter.string(from: resultDecimal) ?? "Something went wrong"
        case 2:
            let resultDecimal = multiply(first: firstNumber, second: secondNumber)
            result = formatter.string(from: resultDecimal) ?? "Something went wrong"
        case 3:
            let resultDecimal = divide(first: firstNumber, second: secondNumber)
            result = formatter.string(from: resultDecimal) ?? "Something went wrong"
        default:
            result = "Something went wrong"
        }
    }
    
    func plus(first: NSDecimalNumber, second: NSDecimalNumber) -> NSDecimalNumber {
        return first.adding(second)
    }
    
    func minus(first: NSDecimalNumber, second: NSDecimalNumber) -> NSDecimalNumber {
        return first.subtracting(second)
    }
    
    func multiply(first: NSDecimalNumber, second: NSDecimalNumber) -> NSDecimalNumber {
        return first.multiplying(by: second)
    }
    
    func divide(first: NSDecimalNumber, second: NSDecimalNumber) -> NSDecimalNumber {
        return first.dividing(by: second)
    }
    
    func tapInfo() {
        showingView = true
    }
}
