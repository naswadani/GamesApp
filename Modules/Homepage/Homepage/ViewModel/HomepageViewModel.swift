//
//  HomepageViewModel.swift
//  Dicoding Games
//
//  Created by naswakhansa on 30/12/24.
//


import Foundation
import CoreData
import Combine
import Core
import GameDetail

enum HomepageState {
    case idle
    case loading
    case failed(String)
}

class HomepageViewModel: ObservableObject {
    private let usecase: HomepageUseCaseProtocol
    private var stateManager = FavoriteGameStateManager.shared
    private var cancellables = Set<AnyCancellable>()
    private var context: NSManagedObjectContext
    
    @Published var showToast: Bool = false
    @Published var isDataLoaded: Bool = false
    @Published var toastMessage: String?
    @Published var state: HomepageState = .idle
    @Published var nextLink: String?
    @Published var prevLink: String?
    @Published var scrollToTop: Bool = false
    @Published var gamesListData: [Game] = []
    
    init(usecase: HomepageUseCaseProtocol,
         context: NSManagedObjectContext) {
        self.context = context
        self.usecase = usecase
        
        stateManager.favoriteGameStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] gameId, isFavorite in
                if let index = self?.gamesListData.firstIndex(where: { $0.id == gameId }) {
                    self?.gamesListData[index].isFavorite = isFavorite
                }
            }
            .store(in: &cancellables)
    }
    
    func showToast(toastMessage: String) {
        showToast = true
        self.toastMessage = toastMessage
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
    
    func updateHomepageState(_ state: HomepageState) {
        self.state = state
    }
    
    func fetchDataGames(url: String?) {
        guard !isDataLoaded else { return }
        
        updateHomepageState(.loading)
        
        usecase.fetchHomepageData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleFetchDataGamesFailure(error)
                case .finished:
                    break
                }
                
            }, receiveValue: { [weak self] response in
                self?.handleFetchDataGamesSuccess(response)
            })
            .store(in: &cancellables)
    }
    
    func fetchNextData() {
        self.isDataLoaded = false
        self.scrollToTop = true
        fetchDataGames(url: nextLink)
    }
    
    func fetchPrevData() {
        self.isDataLoaded = false
        self.scrollToTop = true
        fetchDataGames(url: prevLink)
    }
    
    private func handleFetchDataGamesSuccess(_ games: ListGamesResponseModel) {
        self.gamesListData = games.games.map { game in
            var gameWithFavoriteStatus: Game = game
            gameWithFavoriteStatus.isFavorite = isFavoriteGame(Int64(game.id))
            return gameWithFavoriteStatus
        }
        self.nextLink = games.next
        self.prevLink = games.previous
        self.isDataLoaded = true
        updateHomepageState(.idle)
    }
    
    private func handleFetchDataGamesFailure(_ error: Error) {
        updateHomepageState(.failed(error.localizedDescription))
    }
    
    func saveFavoriteGame(game: Game) {
        usecase.saveFavoriteGame(game: game, context: context)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    self.showToast(toastMessage: "Gagal menambahkan ke favorit")
                case .finished:
                    break
                }
            }, receiveValue: { success in
                if let index = self.gamesListData.firstIndex(where: { $0.id == game.id }) {
                    self.gamesListData[index].isFavorite = true
                }
                self.stateManager.favoriteGameStatePublisher.send((game.id, true))
                self.showToast(toastMessage: "Berhasil menambahkan ke daftar favorite")
            })
            .store(in: &cancellables)
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
                    if let index = self.gamesListData.firstIndex(where: { $0.id == id }) {
                        self.gamesListData[index].isFavorite = false
                    }
                    self.stateManager.favoriteGameStatePublisher.send((id, false))
                    self.showToast(toastMessage: "Berhasil menghapus dari favorit")
                }
            })
            .store(in: &cancellables)
    }
    
    private func isFavoriteGame(_ gameId: Int64) -> Bool {
        let fetchRequest: NSFetchRequest<EntityGames> = EntityGames
            .fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", gameId)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            updateHomepageState(.failed("Failed to check if game is favorite: \(error)"))
            return false
        }
    }
    
    func getDetailViewModel(for gameId: Int) -> GameDetailViewModel {
        guard let viewModel = DependencyContainer.shared.container.resolve(GameDetailViewModel.self, argument: gameId) else {
            fatalError("Failed to resolve GameDetailViewModel for gameId: \(gameId)")
        }
        return viewModel
    }
    
}

