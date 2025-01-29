//
//  HomepageDataSourceRemote.swift
//  Dicoding Games
//
//  Created by naswakhansa on 30/12/24.
//

import Alamofire
import Combine
import CoreData
import Core

class HomepageDataSource: HomepageDataSourceProtocol {
    private let apiConfig: APIConfigProtocol
    private let context: NSManagedObjectContext
    
    init(apiConfig: APIConfigProtocol, context: NSManagedObjectContext) {
        self.apiConfig = apiConfig
        self.context = context
    }
    
    func fetchHomepageData(url: String?) -> AnyPublisher<ListGamesResponseModel, AFError> {
        let urlAPI: String = url ?? apiConfig.endpoint(for: "/games?key=")
        
        return Future<ListGamesResponseModel, AFError> { promise in
            AF.request(urlAPI, method: .get)
                .responseDecodable(of: ListGamesResponseModel.self) { response in
                    switch response.result {
                    case .success(let gameData):
                        promise(.success(gameData))
                    case .failure(let error):
                        promise(.failure(error))
                    }
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
    
    func saveFavoriteGame(game: Game, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error> {
        let favoriteGameEntity = EntityGames(context: context)
        favoriteGameEntity.id = Int64(game.id)
        favoriteGameEntity.name = game.name
        favoriteGameEntity.released = game.released
        favoriteGameEntity.backgroundImage = game.backgroundImage
        favoriteGameEntity.rating = game.formattedRating
        
        do {
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
