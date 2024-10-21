//
//  MainViewViewModel.swift
//  calculator
//
//  Created by Victoria Samsonova on 21.10.24.
//

import Foundation

class MainViewViewModel: ObservableObject {
    
    @Published var result = ""
    
    func count(first: String, second: String, tag: Int) {

        guard let firstNumber = Int128(first), let secondNumber = Int128(second) else {
            result = "You can enter only numbers"
            return
        }
        
        result = String(tag == 0 ? plus(first: firstNumber, second: secondNumber) : minus(first: firstNumber, second: secondNumber))
        
    }
    
    func plus(first: Int128, second: Int128) -> Int128 {
        return first + second
    }
    
    func minus(first: Int128, second: Int128) -> Int128 {
        return first - second
    }
}
