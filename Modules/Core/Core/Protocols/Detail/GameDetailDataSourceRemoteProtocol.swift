//
//  GameDetailDataSourceRemoteProtocol.swift
//  Core
//
//  Created by naswakhansa on 27/01/25.
//

import Combine
import Alamofire

public protocol GameDetailDataSourceRemoteProtocol {
    func fetchGameDetail(with id: Int) -> AnyPublisher<GameDetailResponseModel, AFError>
}
