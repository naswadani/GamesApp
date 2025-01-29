//
//  FavoriteGameViewModel.swift
//  Dicoding Games
//
//  Created by naswakhansa on 05/01/25.
//

import Foundation
import Combine
import CoreData
import Core
import GameDetail


enum FavoriteState {
    case idle
    case loading
    case failed(String)
    case empty(String)
}

class FavoriteGameViewModel: ObservableObject {
    private var stateManager = FavoriteGameStateManager.shared
    private let usecase: FavoritesGameUseCaseProtocol
    private let context: NSManagedObjectContext
    
    @Published var favoritesGame: [Game] = []
    @Published var state: FavoriteState = .idle
    @Published var toastMessage: String?
    @Published var showToast: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FavoritesGameUseCaseProtocol, context: NSManagedObjectContext) {
        self.usecase = usecase
        self.context = context
    }
    
    private func showToast(toastMessage: String) {
        showToast = true
        self.toastMessage = toastMessage
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
    
    func updateFavoriteState(_ state: FavoriteState) {
        self.state = state
    }
    
    func fetchFavoriteGames() {
        updateFavoriteState(.loading)
        usecase.fetchFavoriteGames(context: context)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.updateFavoriteState(.failed(error.localizedDescription))
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] games in
                if games.isEmpty {
                    self?.updateFavoriteState(.empty("No favorite games found."))
                } else {
                    self?.favoritesGame = games
                    self?.updateFavoriteState(.idle)
                }
            })
            .store(in: &cancellables)
    }
    
    func getDetailViewModel(for gameId: Int) -> GameDetailViewModel {
        guard let viewModel = DependencyContainer.shared.container.resolve(GameDetailViewModel.self, argument: gameId) else {
            fatalError("Failed to resolve GameDetailViewModel for gameId: \(gameId)")
        }
        return viewModel
    }
    
    func deleteFavoriteGame(id: Int) {
        usecase.deleteFavoriteGame(id: id, context: context)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to delete favorite game: \(error.localizedDescription)")
                    self.showToast(toastMessage: "Gagal menghapus dari favorit")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if success {
                    if let index = self.favoritesGame.firstIndex(where: { $0.id == id }) {
                        self.favoritesGame[index].isFavorite = false
                    }
                    self.stateManager.favoriteGameStatePublisher.send((id, false))
                    self.showToast(toastMessage: "Berhasil menghapus dari favorit")
                    self.fetchFavoriteGames()
                }
            })
            .store(in: &cancellables)
    }
}
