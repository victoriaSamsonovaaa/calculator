//
//  ContentView.swift
//  calculator
//
//  Created by Victoria Samsonova on 15.10.24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                PinkBaseView(width: 350, height: 650, cornerRadius: 15, color: Color(#colorLiteral(red: 0.9236200452, green: 0.7912103534, blue: 0.9181208014, alpha: 1)))
                VStack {
                    
                    ZStack {
                        PinkBaseView(width: 200, height: 50, cornerRadius: 15, color: Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        TextFieldView(placeholder: "first number", text: $viewModel.firstNumber)
                    }
                    
                    PickerView(selection: $viewModel.selection1)
                    
                    ZStack {
                        PinkBaseView(width: 200, height: 50, cornerRadius: 15, color: Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        TextFieldView(placeholder: "second number", text: $viewModel.secondNumber)
                    }
                    
                    PickerView(selection: $viewModel.selection2)
                    
                    ZStack {
                        PinkBaseView(width: 200, height: 50, cornerRadius: 15, color: Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        TextFieldView(placeholder: "third number", text: $viewModel.thirdNumber)
                    }
                    
                    PickerView(selection: $viewModel.selection3)
                    
                    ZStack {
                        PinkBaseView(width: 200, height: 50, cornerRadius: 15, color: Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        TextFieldView(placeholder: "fourth number", text: $viewModel.fourthNumber)
                    }
                    
                    Button {
                        viewModel.count()
                    } label: {
                        ZStack {
                            PinkBaseView(width: 220, height: 30, cornerRadius: 6, color: Color(#colorLiteral(red: 0.83298105, green: 0.3774057329, blue: 0.7425976396, alpha: 1)))
                            Text("Count")
                                .foregroundStyle(Color.white)
                                .bold()
                        }
                        .padding(.top, 40)
                    }
                    
                    Section {
                        Picker(selection: $viewModel.rounding, label: Text("Select a rounding")) {
                            Text("Math").tag(0)
                            Text("Accounting").tag(1)
                            Text("Truncate").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(Color(#colorLiteral(red: 0.83298105, green: 0.3774057329, blue: 0.7425976396, alpha: 1)))

                    }
                    .padding(.top, 10)
                    
                    Text(viewModel.result)
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                        .padding(.top, 40)
                        .shadow(color: .white, radius: 4)
                    
                }
                .padding(.horizontal, 40)
                .padding(.top, 40)
                .navigationTitle("Calculator")
            }
            .sheet(isPresented: $viewModel.showingView) {
                NameView(showing: $viewModel.showingView)
            }
            .toolbar {
                ToolbarItem {
                    Button("", systemImage: "info.circle") {
                        viewModel.tapInfo()
                    }
                    .tint(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
                }
            }
        }
    }
}

#Preview {
    MainView()
}
