//
//  TextFieldView.swift
//  calculator
//
//  Created by Victoria Samsonova on 13.11.24.
//

import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    @Binding var text: String
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(.roundedBorder)
            .cornerRadius(10)
            .padding(.horizontal, 80)
            .opacity(0.6)
    }
}

#Preview {
    TextFieldView(placeholder: "Enter", text: .constant(""))
}
