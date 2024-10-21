//
//  PinkBaseView.swift
//  calculator
//
//  Created by Victoria Samsonova on 21.10.24.
//

import SwiftUI

struct PinkBaseView: View {
    
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundStyle(color)
            .frame(width: width, height: height)
            .opacity(0.7)
            .shadow(color: .pink, radius: 4, x: -2, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color)
            )
    }
}

#Preview {
    PinkBaseView(width: 300, height: 80, cornerRadius: 15, color: Color(#colorLiteral(red: 1, green: 0.5424868464, blue: 1, alpha: 1)))
}
