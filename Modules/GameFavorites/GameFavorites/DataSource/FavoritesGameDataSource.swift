//
//  FavoritesGameDataSource.swift
//  Dicoding Games
//
//  Created by naswakhansa on 16/01/25.
//

import Foundation
import Combine
import CoreData
import Core

class FavoritesGameDataSource: FavoritesGameDataSourceProtocol {
    func fetchFavoriteGames(context: NSManagedObjectContext) -> AnyPublisher<[EntityGames], Error> {
        let fetchRequest: NSFetchRequest<EntityGames> = EntityGames.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \EntityGames.name, ascending: true)]
        
        return Future<[EntityGames], Error> { promise in
            do {
                let favoriteEntities = try context.fetch(fetchRequest)
                promise(.success(favoriteEntities))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteFavoriteGame(id: Int, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error> {
        let fetchRequest: NSFetchRequest<EntityGames> = EntityGames.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for object in results {
                context.delete(object)
            }
            
            try context.save()
            
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
