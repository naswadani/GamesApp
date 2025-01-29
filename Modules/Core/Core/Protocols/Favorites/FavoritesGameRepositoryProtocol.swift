//
//  FavoritesGameRepositoryProtocol.swift
//  Core
//
//  Created by naswakhansa on 25/01/25.
//

import Foundation
import Combine
import CoreData

public protocol FavoritesGameRepositoryProtocol {
    func fetchFavoriteGames(context: NSManagedObjectContext) -> AnyPublisher<[EntityGames], Error>
    func deleteFavoriteGame(id: Int, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error>
}
