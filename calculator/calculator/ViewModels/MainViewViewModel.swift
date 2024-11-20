//
//  MainViewViewModel.swift
//  calculator
//
//  Created by Victoria Samsonova on 21.10.24.
//

import Foundation
import UIKit

class MainViewViewModel: ObservableObject {
    
    @Published var result = "0"
    @Published var firstNumber = "0"
    @Published var secondNumber = "0"
    @Published var thirdNumber = "0"
    @Published var fourthNumber = "0"
    @Published var selection1 = 0
    @Published var selection2 = 0
    @Published var selection3 = 0
    @Published var rounding = 0
    @Published var showingView = false
    @Published var roundingMode = 0
    
    
    func processInputs(_ inputs: [String]) -> ([NSDecimalNumber], String?) {
        var values = [NSDecimalNumber]()
        var errorMessage: String?

        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 10


        let groupingSeparator = formatter.groupingSeparator ?? ","
        let decimalSeparator = formatter.decimalSeparator ?? "."

        func processInput(_ input: String) -> NSDecimalNumber {
            let sanitizedInput = input
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: groupingSeparator, with: "")
                .replacingOccurrences(of: decimalSeparator, with: ".")
            
//            let regex = "^-?\\d*(\\.\\d+)?$e"
//            if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: sanitizedInput) {
//                errorMessage = "Wrong format!"
//            }
            
            return NSDecimalNumber(string: sanitizedInput)
        }
        
        for input in inputs {
            let value = processInput(input)
            values.append(value)
        }

        return (values, errorMessage)
    }
    
    
    func pressCount(sel1: Int, sel2: Int, sel3: Int, first: String, second: String, third: String, fourth: String, roundMode: Int) -> String {
        let inputs = [first, second, third, fourth]
        let (inputsInDec, errorMessage) = processInputs(inputs)
        
        if let errorMessage = errorMessage {
            self.result = errorMessage
        }

        let selections = [sel1, sel2, sel3]
        let values = inputsInDec

        typealias NSDecimalOperation = (NSDecimalNumber, NSDecimalNumber) -> NSDecimalNumber
        var operations: [Int: NSDecimalOperation] = [:]

        operations[0] = plus
        operations[1] = minus
        operations[2] = multiply
        operations[3] = divide

        guard let operationForSecondThird = operations[selections[1]],
              let operationForFirstAndResult = operations[selections[0]],
              let operationForResultAndFourth = operations[selections[2]] else {
            print("mda")
            let errorMessage = "Invalid selection"
            self.result = errorMessage
            return errorMessage
        }

        let secondThirdResult = operationForSecondThird(values[1] as NSDecimalNumber, values[2] as NSDecimalNumber)
        
        let firstAndSecondThirdResult = operationForFirstAndResult(values[0] as NSDecimalNumber, secondThirdResult)
        
        var ans = operationForResultAndFourth(firstAndSecondThirdResult, values[3] as NSDecimalNumber)
        
        ans = myRound(inp: ans, mode: roundMode) as NSDecimalNumber
        
        let stringAns = ans.stringValue
        print(stringAns)
        return stringAns
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

    func myRound(inp: NSDecimalNumber, mode: Int) -> Decimal {
        var ans = inp.decimalValue
        var roundingMode: NSDecimalNumber.RoundingMode
        switch mode {
        case 0: return ans
        case 1: roundingMode = .plain
        case 2: roundingMode = .bankers
        case 3: roundingMode = .down
        default: return ans
        }
        var result = Decimal()
        NSDecimalRound(&result, &ans, 6, roundingMode)
        return result
    }
    
    func tapInfo() {
        showingView = true
    }
}
