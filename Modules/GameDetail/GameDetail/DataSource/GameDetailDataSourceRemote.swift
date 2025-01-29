//
//  GameDetailDataSourceRemote.swift
//  Dicoding Games
//
//  Created by naswakhansa on 31/12/24.
//

import Foundation
import Alamofire
import Combine
import Core

class GameDetailDataSourceRemote: GameDetailDataSourceRemoteProtocol {
    private let apiConfig: APIConfigProtocol
    
    init(apiConfig: APIConfigProtocol) {
        self.apiConfig = apiConfig
    }
    
    func fetchGameDetail(with id: Int) -> AnyPublisher<GameDetailResponseModel, AFError> {
        return Future<GameDetailResponseModel, AFError> { promise in
            AF.request(self.apiConfig.gameDetail(for: id), method: .get)
                .responseDecodable(of: GameDetailResponseModel.self) { response in
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
    
    
    
}
