//
//  GameDetailUseCaseRemoteProtocol.swift
//  Game Detail
//
//  Created by naswakhansa on 15/01/25.
//

import Foundation
import Alamofire
import Combine
import Core

class GameDetailUseCaseRemote: GameDetailUseCaseRemoteProtocol {
    private let repository: GameDetailRepositoryRemoteProtocol
    
    init(repository: GameDetailRepositoryRemoteProtocol) {
        self.repository = repository
    }
    
    func fetchGameDetail(with id: Int) -> AnyPublisher<GameDetailResponseModel, AFError> {
        repository.fetchGameDetail(with: id)
    }
}
