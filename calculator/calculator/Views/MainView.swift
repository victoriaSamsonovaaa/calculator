//
//  ContentView.swift
//  calculator
//
//  Created by Victoria Samsonova on 15.10.24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    @State private var firstNumber = ""
    @State private var secondNumber = ""
    @State private var selection = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                PinkBaseView(width: 350, height: 600, cornerRadius: 15, color: Color(#colorLiteral(red: 0.9236200452, green: 0.7912103534, blue: 0.9181208014, alpha: 1)))
                
                VStack {
                    ZStack {
                        PinkBaseView(width: 300, height: 80, cornerRadius: 15, color: Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        
                        TextField("Input first number", text: $firstNumber)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 30)
                            .opacity(0.6)
                    }
                    
                    Section {
                        Picker(selection: $selection, label: Text("Select an operation")) {
                            Text("Plus").tag(0)
                            Text("Minus").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 100)
                    
                    ZStack {
                        PinkBaseView(width: 300, height: 80, cornerRadius: 15, color: Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        
                        TextField("Input second number", text: $secondNumber)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 30)
                            .opacity(0.6)
                    }
                    .padding(.bottom, 40)
                    
                    Button {
                        viewModel.count(first: firstNumber, second: secondNumber, tag: selection)
                    } label: {
                        ZStack {
                            PinkBaseView(width: 110, height: 30, cornerRadius: 6, color: Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                            Text("Count")
                                .foregroundStyle(Color.white)
                                .bold()
                        }
                    }
                    
                    Text(viewModel.result)
                        .bold()
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(.top, 40)
                    
                    
                }
                .padding(.horizontal, 40)
                .padding(.top, 40)
                .navigationTitle("Calculator")
                
            }
            
        }
    }
}

#Preview {
    MainView()
}
