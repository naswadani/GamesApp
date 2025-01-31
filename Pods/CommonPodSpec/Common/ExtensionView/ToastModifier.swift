//
//  ToastModifier.swift
//  Dicoding Games
//
//  Created by naswakhansa on 04/01/25.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    let message: String
    let show: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ToastView(message: message, show: show)
        }
    }
}
