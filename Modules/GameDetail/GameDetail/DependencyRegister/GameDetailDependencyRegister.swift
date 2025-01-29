//
//  GameDetailDependencyRegister.swift
//  GameDetail
//
//  Created by naswakhansa on 27/01/25.
//

import Foundation
import Core

public struct GameDetailDependencyRegister: Registrable {
    public static func registerDependencies(in container: DependencyContainer) {
        container.register(GameDetailDataSourceRemoteProtocol.self) { resolver in
            guard let apiConfig = resolver.resolve(APIConfigProtocol.self) else {
                fatalError("Failed to resolve APIConfigProtocol")
            }
            return GameDetailDataSourceRemote(apiConfig: apiConfig)
        }

        container.register(GameDetailRepositoryRemoteProtocol.self) { resolver in
            guard let dataSource = resolver.resolve(GameDetailDataSourceRemoteProtocol.self) else {
                fatalError("Failed to resolve GameDetailDataSourceRemoteProtocol")
            }
            return GameDetailRepositoryRemote(dataSource: dataSource)
        }

        container.register(GameDetailUseCaseRemoteProtocol.self) { resolver in
            guard let repository = resolver.resolve(GameDetailRepositoryRemoteProtocol.self) else {
                fatalError("Failed to resolve GameDetailRepositoryRemoteProtocol")
            }
            return GameDetailUseCaseRemote(repository: repository)
        }

        container.register(GameDetailViewModel.self) { (resolver, selectedGameId: Int) in
            guard let usecase = resolver.resolve(GameDetailUseCaseRemoteProtocol.self) else {
                fatalError("Failed to resolve dependencies for GameDetailViewModel")
            }
            return GameDetailViewModel(usecase: usecase, selectedGameId: selectedGameId)
        }
    }
}
