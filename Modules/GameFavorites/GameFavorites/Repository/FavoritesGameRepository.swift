//
//  FavoritesRepository.swift
//  Dicoding Games
//
//  Created by naswakhansa on 16/01/25.
//

import Foundation
import Combine
import CoreData
import Core

class FavoritesGameRepository: FavoritesGameRepositoryProtocol {
    
    private let dataSource: FavoritesGameDataSourceProtocol
    
    init(dataSource: FavoritesGameDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func fetchFavoriteGames(context: NSManagedObjectContext) -> AnyPublisher<[EntityGames], Error> {
        return dataSource.fetchFavoriteGames(context: context)
    }
    
    func deleteFavoriteGame(id: Int, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error> {
        dataSource.deleteFavoriteGame(id: id, context: context)
    }
}
