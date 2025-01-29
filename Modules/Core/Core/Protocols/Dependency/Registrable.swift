//
//  Registrable.swift
//  Core
//
//  Created by naswakhansa on 27/01/25.
//


import Swinject

public protocol Registrable {
    static func registerDependencies(in container: DependencyContainer)
}
