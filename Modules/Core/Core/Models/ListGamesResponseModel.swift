//
//  ListGamesResponseModel.swift
//  Dicoding Games
//
//  Created by naswakhansa on 30/12/24.
//

import Foundation

public struct ListGamesResponseModel: Codable, Equatable {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case games = "results"
    }
}

public struct Game: Identifiable, Codable, Equatable {
    public let id: Int
    public let name: String?
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double?
    public var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating, isFavorite
    }
    
    public var formattedRating: String {
        if let rating = rating {
            return String(format: "%.1f", rating)
        }
        return "N/A"
    }
}


