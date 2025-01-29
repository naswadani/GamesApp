//
//  APIConfig.swift
//  Core
//
//  Created by naswakhansa on 25/01/25.
//

import Foundation

public final class APIConfig: APIConfigProtocol {
    let baseURL: String = "https://api.rawg.io/api"
    let keyAPI: String = "f37cf8ff79df40fb86119195611f72ac"
    
    public func endpoint(for path: String) -> String {
        return "\(baseURL)\(path)\(keyAPI)"
    }
    
    public func gameDetail(for gameId: Int) -> String {
        return "\(baseURL)/games/\(gameId)?key=\(keyAPI)"
    }
    
    public init() {}
}
