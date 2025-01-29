//
//  DependencyRegister.swift
//  Core
//
//  Created by naswakhansa on 25/01/25.
//

import Swinject

public protocol DependencyRegister {
    static func register(to container: Container)
}
