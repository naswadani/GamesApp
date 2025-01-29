//
//  GameDetailViewModel.swift
//  Dicoding Games
//
//  Created by naswakhansa on 31/12/24.
//

import Foundation
import Combine
import Core


enum GameDetailState {
    case idle
    case loading
    case failed(String)
    
}

public class GameDetailViewModel: ObservableObject {
    private let usecase: GameDetailUseCaseRemoteProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var state: GameDetailState = .idle
    @Published var genreGame: String?
    @Published var developerGame: String?
    @Published var platfromGame: String?
    @Published var gameDetail: GameDetailResponseModel?
    @Published var selectedGameId: Int
    
    public init(usecase: GameDetailUseCaseRemoteProtocol, selectedGameId: Int) {
        self.usecase = usecase
        self.selectedGameId = selectedGameId
    }
    
    func updateGameDetailState(_ state: GameDetailState) {
        self.state = state
    }
    
    func fetchGameDetail() {
        updateGameDetailState(.loading)
        usecase.fetchGameDetail(with: selectedGameId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.fetchGameDetailFailure(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.fetchGameDetailSuccess(response)
            })
            .store(in: &cancellables)
    }
    
    private func convertPlatfromToString(from array: [Platforms]) -> String {
        let arrayString = Set(array.map { $0.platform.name })
        return arrayString.joined(separator: ", ")
    }
    
    private func convertDeveloperToString(from array: [Developers]) -> String {
        let arrayString = Set(array.map { $0.name })
        return arrayString.joined(separator: ", ")
    }
    
    
    private func fetchGameDetailSuccess(_ game: GameDetailResponseModel) {
        if let platfromGame = game.platforms {
            self.platfromGame = convertPlatfromToString(from: platfromGame)

        }
        
        if let developerGame = game.developers {
            self.developerGame = convertDeveloperToString(from: developerGame)
        }
        
        if let genreGame = game.genres {
            self.genreGame = convertDeveloperToString(from: genreGame)
        }
        
        self.gameDetail = game
        
        updateGameDetailState(.idle)
    }
    
    private func fetchGameDetailFailure(_ error: Error) {
        updateGameDetailState(.failed(error.localizedDescription))
    }
}

