//
//  FavoriteGameStateManager.swift
//  Core
//
//  Created by naswakhansa on 25/01/25.
//


import Foundation
import Combine

public class FavoriteGameStateManager {
    public static let shared = FavoriteGameStateManager()
    
    public let favoriteGameStatePublisher = PassthroughSubject<(Int, Bool), Never>()
    
    private init() {}
}
