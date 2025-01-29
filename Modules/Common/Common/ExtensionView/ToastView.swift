//
//  ToastView.swift
//  Dicoding Games
//
//  Created by naswakhansa on 04/01/25.
//


import SwiftUI

struct ToastView: View {
    let message: String
    let show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if show {
                Text(message)
                    .padding()
                    .background(Color.black.opacity(0.7), in: RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: show)
            }
        }
        .padding()
    }
}
