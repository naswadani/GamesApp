//
//  HomepageDependencyRegistration.swift
//  Homepage
//
//  Created by naswakhansa on 25/01/25.
//

import Core
import Foundation
import Combine
import Swinject
import CoreData


public struct HomepageDependencyRegistration: Registrable {
    public static func registerDependencies(in container: DependencyContainer) {
        container.register(APIConfigProtocol.self) { _ in
            APIConfig()
        }

        container.register(HomepageDataSourceProtocol.self) { resolver in
            guard let apiConfig = resolver.resolve(APIConfigProtocol.self),
                  let context = resolver.resolve(NSManagedObjectContext.self)
            else {
                fatalError("Failed to resolve dependencies for HomepageDataSourceProtocol")
            }
            return HomepageDataSource(apiConfig: apiConfig, context: context)
        }

        container.register(HomepageRepositoryProtocol.self) { resolver in
            guard let dataSource = resolver.resolve(HomepageDataSourceProtocol.self) else {
                fatalError("Failed to resolve HomepageDataSourceProtocol")
            }
            return HomepageRepository(dataSource: dataSource)
        }

        container.register(HomepageUseCaseProtocol.self) { resolver in
            guard let repository = resolver.resolve(HomepageRepositoryProtocol.self) else {
                fatalError("Failed to resolve HomepageRepositoryProtocol")
            }
            return HomepageUseCase(repository: repository)
        }

        container.register(NSManagedObjectContext.self) { _ in
            PersistenceController.shared.context
        }

        container.register(HomepageViewModel.self) { resolver in
            guard
                let usecase = resolver.resolve(HomepageUseCaseProtocol.self),
                let context = resolver.resolve(NSManagedObjectContext.self)
            else {
                fatalError("Failed to resolve dependencies for HomepageViewModel")
            }
            return HomepageViewModel(usecase: usecase, context: context)
        }
    }
}

