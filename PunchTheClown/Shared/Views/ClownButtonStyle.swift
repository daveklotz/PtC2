//
//  ClownButtonStyle.swift
//  iOS
//
//  Created by David Klotz on 1/31/21.
//

import SwiftUI

struct ClownButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            
            .background(Color.red.opacity(0.6))
            .foregroundColor(Color.yellow)
            .cornerRadius(20.0)
            .overlay(
                RoundedRectangle(cornerRadius: 20.0).stroke(Color(.systemRed), lineWidth: 2)
            ).padding([.top, .bottom], 40)
//            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut(duration: 0.2))
            .font(.headline)
            
    }
}
