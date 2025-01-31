//
//  FavoriteGameView.swift
//  Dicoding Games
//
//  Created by naswakhansa on 04/01/25.
//

import SwiftUI
import Core
import CommonPodSpec
import GameDetail

public struct FavoriteGameView: View {
    @StateObject var viewModel: FavoriteGameViewModel
    
    public init() {
        let container = DependencyContainer.shared
        guard let resolvedViewModel = container.resolve(FavoriteGameViewModel.self) else {
            fatalError("Failed to resolve HomepageViewModel")
        }
        _viewModel = StateObject(wrappedValue: resolvedViewModel)
    }
    
    public var body: some View {
        ZStack {
            Color.gray.opacity(0.5).ignoresSafeArea(.all)
            switch viewModel.state {
            case .idle:
                ScrollView(.vertical, showsIndicators: false) {
                    VStack (spacing: 15) {
                        ForEach(viewModel.favoritesGame) { game in
                            NavigationLink(destination: {
                                let detailViewModel = viewModel.getDetailViewModel(for: game.id)
                                GameDetailView(viewModel: detailViewModel)
                            }) {
                                ItemGamesListView(
                                    game: game,
                                    isFavorite: .constant(game.isFavorite),
                                    addToFavorites: {},
                                    removeFromFavorites: {
                                        viewModel.deleteFavoriteGame(id: game.id)
                                    })
                            }
                        }
                        
                    }
                }
            case .loading:
                ProgressView()
            case .failed(let error):
                StateView(message: error) {
                    viewModel.fetchFavoriteGames()
                }
            case .empty(let message):
                StateView(message: message, action: nil)
            }
        }
        .onAppear {
            viewModel.fetchFavoriteGames()
        }
        .toast(message: viewModel.toastMessage ?? "", show: viewModel.showToast)
    }
}
