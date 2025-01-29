//
//  APIConfigProtocol.swift
//  Core
//
//  Created by naswakhansa on 25/01/25.
//


public protocol APIConfigProtocol {
    func endpoint(for path: String) -> String
    func gameDetail(for gameId: Int) -> String
}
