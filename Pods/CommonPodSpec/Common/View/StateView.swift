//
//  ErrorStateView.swift
//  Common
//
//  Created by naswakhansa on 01/01/25.
//

import SwiftUI

public struct StateView: View {
    
    let message: String
    let action: (() -> Void)?
    
    public init(message: String, action: ( () -> Void)?) {
        self.message = message
        self.action = action
    }
 
    public var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text(message)
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            if let action = action {
                Button(action: {
                    action()
                }) {
                    Text("Retry")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                        )
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    StateView(message: "Maaf aplikasi error", action: {})
}
