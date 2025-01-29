//
//  AppContainer.swift
//  Core
//
//  Created by naswakhansa on 25/01/25.
//

import Swinject
import CoreData

public protocol ResolverType {
    func resolve<Service>(_ serviceType: Service.Type) -> Service?
    func resolve<Service, Arg>(_ serviceType: Service.Type, argument: Arg) -> Service?
}

public class DependencyContainer: ResolverType {
    public static let shared = DependencyContainer()
    public let container: Container
    
    private init() {
        self.container = Container()
    }
    
    public func register<Service>(_ serviceType: Service.Type, factory: @escaping (Resolver) -> Service) {
        container.register(serviceType, factory: factory)
    }
    
    public func register<Service, Arg>(_ serviceType: Service.Type, factory: @escaping (Resolver, Arg) -> Service) {
        container.register(serviceType, factory: factory)
    }
    
    public func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
    
    public func resolve<Service, Arg>(_ serviceType: Service.Type, argument: Arg) -> Service? {
        return container.resolve(serviceType, argument: argument)
    }
}
