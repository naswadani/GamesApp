//
//  GameFavoritesDependencyRegister.swift
//  GameFavorites
//
//  Created by naswakhansa on 25/01/25.
//

import Swinject
import CoreData
import Core

public struct GameFavoritesDependencyRegister: Registrable {
    public static func registerDependencies(in container: DependencyContainer) {
        container.register(FavoritesGameDataSourceProtocol.self) { _ in
            FavoritesGameDataSource()
        }

        container.register(FavoritesGameRepositoryProtocol.self) { resolver in
            guard let dataSource = resolver.resolve(FavoritesGameDataSourceProtocol.self) else {
                fatalError("Failed to resolve FavoritesGameDataSourceProtocol")
            }
            return FavoritesGameRepository(dataSource: dataSource)
        }

        container.register(FavoritesGameUseCaseProtocol.self) { resolver in
            guard let repository = resolver.resolve(FavoritesGameRepositoryProtocol.self) else {
                fatalError("Failed to resolve FavoritesGameRepositoryProtocol")
            }
            return FavoritesGameUseCase(repository: repository)
        }

        container.register(FavoriteGameViewModel.self) { resolver in
            guard
                let usecase = resolver.resolve(FavoritesGameUseCaseProtocol.self),
                let context = resolver.resolve(NSManagedObjectContext.self)
            else {
                fatalError("Failed to resolve dependencies for FavoriteGameViewModel")
            }
            return FavoriteGameViewModel(usecase: usecase, context: context)
        }
    }
}

