//
//  HomepageRepositoryRemoteProtocol.swift
//  Dicoding Games
//
//  Created by naswakhansa on 30/12/24.
//


import Alamofire
import Combine
import CoreData
import Core

class HomepageRepository: HomepageRepositoryProtocol {
    let dataSource: HomepageDataSourceProtocol
    
    init(dataSource: HomepageDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func fetchHomepageData(url: String?) -> AnyPublisher<ListGamesResponseModel, AFError> {
        dataSource.fetchHomepageData(url: url)
    }
    
    func deleteFavoriteGame(id: Int, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error> {
        dataSource.deleteFavoriteGame(id: id, context: context)
    }
    
    func saveFavoriteGame(game: Game, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error> {
        dataSource.saveFavoriteGame(game: game, context: context)
    }
}
