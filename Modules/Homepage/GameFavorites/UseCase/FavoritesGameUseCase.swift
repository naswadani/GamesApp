//
//  FavoritesUseCase.swift
//  Dicoding Games
//
//  Created by naswakhansa on 16/01/25.
//

import Foundation
import CoreData
import Combine
import Core

class FavoritesGameUseCase: FavoritesGameUseCaseProtocol {
    private let repository: FavoritesGameRepositoryProtocol
    
    init(repository: FavoritesGameRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchFavoriteGames(context: NSManagedObjectContext) -> AnyPublisher<[Game], Error> {
        return repository.fetchFavoriteGames(context: context)
            .map { $0.map(\.toGame) }
            .eraseToAnyPublisher()
    }
    
    func deleteFavoriteGame(id: Int, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error> {
        repository.deleteFavoriteGame(id: id, context: context)
    }
}
