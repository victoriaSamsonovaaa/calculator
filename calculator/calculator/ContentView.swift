//
//  ContentView.swift
//  calculator
//
//  Created by Victoria Samsonova on 15.10.24.
//

import SwiftUI

struct ContentView: View {
    @State private var firstNumber = ""
    @State private var secondNumber = ""
    @State private var selection = 0
    private let operations = ["+", "-"]
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        .frame(width: 360, height: 100)
                        .opacity(0.7)
                        .shadow(color: .pink, radius: 6, x: -2, y: 1)
                    
                    TextField("Input first number", text: $firstNumber)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 15)
                        .opacity(0.6)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                )
                .padding(.bottom, 30)
                
                Section {
                    Picker(selection: $selection, label: Text("Select an operation")) {
                        Text("Plus").tag(0)
                        Text("Minus").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .colorMultiply(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                }
                .padding(.horizontal, 60)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        .frame(width: 360, height: 100)
                        .opacity(0.7)
                        .shadow(color: .pink, radius: 6, x: -2, y: 1)
                    
                    TextField("Input second number", text: $secondNumber)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 15)
                        .opacity(0.6)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                )
                .padding(.top, 30)
                
                Spacer()
            }
            .padding(.horizontal, 40)
            .padding(.top, 40)
            .navigationTitle("Calculator")
        }

    }
}

#Preview {
    ContentView()
}
