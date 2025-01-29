//
//  GameDetailUseCaseRemoteProtocol.swift
//  Core
//
//  Created by naswakhansa on 27/01/25.
//

import Combine
import Alamofire

public protocol GameDetailUseCaseRemoteProtocol {
    func fetchGameDetail(with id: Int) -> AnyPublisher<GameDetailResponseModel, AFError>
}
