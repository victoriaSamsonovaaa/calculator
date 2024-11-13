//
//  PickerView.swift
//  calculator
//
//  Created by Victoria Samsonova on 13.11.24.
//

import SwiftUI

struct PickerView: View {
    @Binding var selection: Int
    var body: some View {
        Section {
            Picker(selection: $selection, label: Text("Select an operation")) {
                Text("Plus").tag(0)
                Text("Minus").tag(1)
                Text("Multiply").tag(2)
                Text("Divide").tag(3)
            }
            .pickerStyle(.segmented)
            .colorMultiply(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))

        }
        .padding(.vertical, 10)
        .padding(.horizontal, 40)
    }
}

#Preview {
    PickerView(selection: .constant(0))
}
