//
//  AboutView.swift
//  Common
//
//  Created by naswakhansa on 01/01/25.
//

import SwiftUI

public struct AboutView: View {
    let image: String

    public init(image: String) {
        self.image = image
    }
    
    public var body: some View {
        ZStack {
            Color.gray.opacity(0.5).ignoresSafeArea(.all)
            VStack(spacing: 25) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 3)
                    )
                
                Text("Naswa Bryna Danikhansa")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
            }
        }
    }
}

#Preview {
    AboutView(image: "naswa")
}
