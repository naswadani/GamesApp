//
//  HomepageDataSourceProtocol.swift
//  Core
//
//  Created by naswakhansa on 25/01/25.
//

import Combine
import CoreData
import Alamofire

public protocol HomepageDataSourceProtocol {
    func fetchHomepageData(url: String?) -> AnyPublisher<ListGamesResponseModel, AFError>
    func deleteFavoriteGame(id: Int, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error>
    func saveFavoriteGame(game: Game, context: NSManagedObjectContext) -> AnyPublisher<Bool, Error>
}
