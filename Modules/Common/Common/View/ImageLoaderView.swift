//
//  ImageLoaderView.swift
//  Common
//
//  Created by naswakhansa on 30/12/24.
//

import SwiftUI

public struct ImageLoaderView: View {
    
    let paddingButton: CGFloat
    let imageURL: String?
    let sizeFont: CGFloat
    
    public init(paddingButton: CGFloat, imageURL: String?, sizeFont: CGFloat) {
        self.paddingButton = paddingButton
        self.imageURL = imageURL
        self.sizeFont = sizeFont
    }
    
    public var body: some View {
        Group {
            AsyncImage(url: URL(string: imageURL ?? "")) { phase in
                switch phase {
                case .empty:
                    Color.white.ignoresSafeArea(.all)
                    ProgressView()
                        .background(.white)
                        .padding(.bottom, paddingButton)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Image(systemName: "photo.on.rectangle")
                        .font(.system(size: sizeFont))
                        .foregroundColor(.gray)
                        .padding(.bottom, paddingButton)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
