//
//  FavoritesGameUseCaseProtocol.swift
//  Core
//
//  Created by naswakhansa on 25/01/25.
//

import Foundation
import Combine
import CoreData

public protocol FavoritesGameUseCaseProtocol {
    func fetchFavoriteGames(context: NSManagedObjectContext) -> AnyPublisher<[Game], Error>
    func deleteFavoriteGame(id: Int, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error>
}
