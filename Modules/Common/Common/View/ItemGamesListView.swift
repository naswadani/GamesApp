//
//  ItemGamesListView.swift
//  Common
//
//  Created by naswakhansa on 30/12/24.
//


import SwiftUI
import Core

public struct ItemGamesListView: View {
    let game: Game
    @Binding var isFavorite: Bool?
    var addToFavorites: () -> Void
    let removeFromFavorites: () -> Void
    
    public init(game: Game, isFavorite: Binding<Bool?>, addToFavorites: @escaping () -> Void, removeFromFavorites: @escaping () -> Void) {
        self.game = game
        self._isFavorite = isFavorite
        self.addToFavorites = addToFavorites
        self.removeFromFavorites = removeFromFavorites
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    if let gameName = game.name {
                        Text(gameName)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    if let released = game.released {
                        Text(released)
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                    }
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                        
                        Text("\(game.formattedRating)/5")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                    }
                }
                Spacer()
            }
            .padding(10)
            .background(
                UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 10.0, bottomTrailing: 10.0), style: .continuous)
                    .frame(width: 350)
                    .foregroundStyle(.white.opacity(0.8))
            )
        }
        .frame(width: 350)
        .frame(height: 200)
        .background(
            ImageLoaderView(paddingButton: 20, imageURL: game.backgroundImage, sizeFont: 20)
        )
        .cornerRadius(10)
        .overlay(
            Group{
                if let isFavorite = isFavorite {
                    Button(action: {
                        if isFavorite {
                            removeFromFavorites()
                        } else {
                            addToFavorites()
                        }
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                    }
                    .offset(x: -10, y: -10)
                }
                
            }
            , alignment: .bottomTrailing
        )
    }
}
