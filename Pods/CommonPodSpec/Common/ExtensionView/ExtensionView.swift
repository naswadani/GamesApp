//
//  ExtensionView.swift
//  Dicoding Games
//
//  Created by naswakhansa on 04/01/25.
//

import SwiftUI

extension View {
    public func toast(message: String, show: Bool) -> some View {
        self.modifier(ToastModifier(message: message, show: show))
    }
}


