//
//  GamesAppApp.swift
//  GamesApp
//
//  Created by naswakhansa on 25/01/25.
//

import SwiftUI
import GameDetail
import Homepage
import GameFavorites
import Core
import CoreData

@main
struct GamesAppApp: App {
    init() {
        DependencyContainer.shared.register(NSManagedObjectContext.self) { _ in
            return PersistenceController.shared.context
        }
        
        DependencyContainer.shared.register(APIConfigProtocol.self) { _ in
            APIConfig()
        }
        GameDetailDependencyRegister.registerDependencies(in: DependencyContainer.shared)
        HomepageDependencyRegister.registerDependencies(in: DependencyContainer.shared)
        GameFavoritesDependencyRegister.registerDependencies(in: DependencyContainer.shared)
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarCustomView()
                .accentColor(Color("AccentColor", bundle: Bundle(identifier: "project.naswa.Common")))
        }
    }
}
