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

    func processInputs(_ inputs: [String]) -> [NSDecimalNumber] {
        var values = [NSDecimalNumber]()

        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 6

        let groupingSeparator = formatter.groupingSeparator ?? ","
        let decimalSeparator = formatter.decimalSeparator ?? "."

        func processInput(_ input: String) -> NSDecimalNumber {
            let sanitizedInput = input
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: groupingSeparator, with: "")
                .replacingOccurrences(of: decimalSeparator, with: ".")

            return NSDecimalNumber(string: sanitizedInput)
        }

        for input in inputs {
            let value = processInput(input)
            values.append(value)
        }

        return values
    }

    func pressCount(sel1: Int, sel2: Int, sel3: Int, first: String, second: String, third: String, fourth: String, roundMode: Int) -> String {
        let inputs = [first, second, third, fourth]
        let inputsInDec = processInputs(inputs)
        let selections = [sel1, sel2, sel3]
        let values = inputsInDec

        typealias NSDecimalOperation = (NSDecimalNumber, NSDecimalNumber) -> NSDecimalNumber
        var operations: [Int: NSDecimalOperation] = [:]

        operations[0] = plus
        operations[1] = minus
        operations[2] = multiply
        operations[3] = divide

        var ans = NSDecimalNumber(0)

        guard let operationForSecondThird = operations[selections[1]],
              let operationForFirstAndSecondThird = operations[selections[0]],
              let operationForSecondThirdAndFourth = operations[selections[2]] else {
            result = "Invalid selection"
            return result
        }

        let firstRes = operationForSecondThird(values[1], values[2])
        if firstRes.compare(NSDecimalNumber.notANumber) == .orderedSame {
            result = "Error(Division by zero)"
            return result
        }

        if selections[0] >= 2 {
            let secondRes = operationForFirstAndSecondThird(values[0], firstRes)
            if secondRes.compare(NSDecimalNumber.notANumber) == .orderedSame {
                result = "Error(Division by zero)"
                return result
            }
            let thirdRes = operationForSecondThirdAndFourth(secondRes, values[3])
            if thirdRes.compare(NSDecimalNumber.notANumber) == .orderedSame {
                result = "Error(Division by zero)"
                return result
            }
            ans = thirdRes
        } else if selections[0] < 2 {
            let secondRes = operationForSecondThirdAndFourth(firstRes, values[3])
            if secondRes.compare(NSDecimalNumber.notANumber) == .orderedSame {
                result = "Error(Division by zero)"
                return result
            }
            let thirdRes = operationForFirstAndSecondThird(values[0], secondRes)
            if thirdRes.compare(NSDecimalNumber.notANumber) == .orderedSame {
                result = "Error(Division by zero)"
                return result
            }
            ans = thirdRes
        }

        ans = roundDecimal(ans, mode: roundMode)
        result = formattedResult(ans.decimalValue)
        return result
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
        if second == NSDecimalNumber.zero {
            return NSDecimalNumber.notANumber
        }
        return first.dividing(by: second)
    }

    func roundDecimal(_ inp: NSDecimalNumber, mode: Int) -> NSDecimalNumber {
        var scale: Int32
        var roundingMode: NSDecimalNumber.RoundingMode

        switch mode {
        case 0:
            return inp
        case 1:
            roundingMode = .plain
            scale = 6
        case 2:
            roundingMode = .bankers
            scale = 6
        case 3:
            if inp.compare(NSDecimalNumber.zero) == .orderedAscending {
                roundingMode = .up
            } else {
                roundingMode = .down
            }
            scale = 0
        default:
            return inp
        }

        let inputDecimal = inp.decimalValue
        let roundedDecimal = inputDecimal.rounded(Int(scale), roundingMode)
        return NSDecimalNumber(decimal: roundedDecimal)
    }

    func tapInfo() {
        showingView = true
    }

    private func formattedResult(_ number: Decimal) -> String {
        let roundedValue = number.rounded(6, .plain)
        let nsDecimalNumber = NSDecimalNumber(decimal: roundedValue)
        let numberString = nsDecimalNumber.stringValue

        let groupingSeparator = " "
        let decimalSeparator = "."

        let components = numberString.split(separator: ".", omittingEmptySubsequences: false)
        guard let integerPart = components.first else {
            return numberString
        }
        let fractionalPart = components.count > 1 ? String(components[1]) : ""

        let integerPartWithGrouping = addGroupingSeparators(to: String(integerPart), groupingSeparator: groupingSeparator)

        return fractionalPart.isEmpty ? integerPartWithGrouping : "\(integerPartWithGrouping)\(decimalSeparator)\(fractionalPart)"
    }

    private func addGroupingSeparators(to integerPart: String, groupingSeparator: String) -> String {
        var result = ""
        var counter = 0

        for char in integerPart.reversed() {
            if counter > 0 && counter % 3 == 0 {
                result.append(groupingSeparator)
            }
            result.append(char)
            counter += 1
        }

        return String(result.reversed())
    }
}

extension Decimal {
    mutating func round(_ scale: Int, _ roundingMode: Decimal.RoundingMode) {
        var localCopy = self
        NSDecimalRound(&self, &localCopy, scale, roundingMode)
    }

    func rounded(_ scale: Int, _ roundingMode: Decimal.RoundingMode) -> Decimal {
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, scale, roundingMode)
        return result
    }
}
