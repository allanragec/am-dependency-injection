//
//  DependencyContainer.swift
//  SecurityManager
//
//  Created by Allan Melo on 09/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AMDependencyInjection
import FeatureFlagAPI

typealias SecurityManagerDependencies =
    HasFeatureFlagService

//public final class DependencyContainer: ContainerResolver, SecurityManagerDependencies {
//    lazy public var featureFlagService: FeatureFlagServiceProtocol = resolve()
//    
//    static let shared: DependencyContainer = {
//        // setup dependencies, can be bound once here or in the configurators
////        DependenciesInjection.registerDependencies()
//        let instance: DependencyContainer = .init(resolver: SecurityManagerResolver.shared)
//        
//        do {
//            try instance.checkIfDependenciesCanBeResolved()
//        }
//        catch let error {
//            print(error)
//        }
//        
//        return instance
//    }()
//    
//    public override func globalDependencies() -> [Any.Type] {
//        [FeatureFlagServiceProtocol.self]
//    }
//}
//
//
//

public final class DependencyContainer: ContainerResolverPublic, SecurityManagerDependencies {
    public static var resolver: DependencyResolver { SecurityManagerResolver.shared }
    
    lazy public var featureFlagService: FeatureFlagServiceProtocol = resolve()
    
//    static let shared: DependencyContainer = {
//        // setup dependencies, can be bound once here or in the configurators
////        DependenciesInjection.registerDependencies()
//        let instance: DependencyContainer = .init(resolver: AnalyticsResolver.shared)
//
//        do {
//            try instance.checkIfDependenciesCanBeResolved()
//        }
//        catch let error {
//            print(error)
//        }
//
//        return instance
//    }()
    
    public override func globalDependencies() -> [Any.Type] {
        [FeatureFlagServiceProtocol.self]
    }
}
