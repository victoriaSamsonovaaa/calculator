//
//  NameView.swift
//  calculator
//
//  Created by Victoria Samsonova on 23.10.24.
//

import SwiftUI

struct NameView: View {
    
    @Binding var showing: Bool
    
    var body: some View {
        if showing {
            VStack {
                Text("Самсонова Виктория Дмитриевна")
                Text("3 курс, 11 группа, 2024 год")
            }
            .font(.title2)
            .bold()
            .foregroundStyle(Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
        }
    }
}

#Preview {
    NameView(showing: Binding(get: {
        return true
    }, set: { _ in

    }))
}
