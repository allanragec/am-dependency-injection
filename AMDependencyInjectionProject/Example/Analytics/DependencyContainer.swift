//
//  DependencyContainer.swift
//  Analytics
//
//  Created by Allan Melo on 09/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AMDependencyInjection
import FeatureFlagAPI

typealias AnalyticsDependencies =
    HasFirebaseAnalytics &
    HasFeatureFlagService

final class DependencyContainer: ContainerResolver, AnalyticsDependencies {
    public static var resolver: DependencyResolver { AnalyticsResolver.shared }
    
    lazy public var featureFlagService: FeatureFlagServiceProtocol = resolve()
    lazy public var firebaseAnalytics: FirebaseAnalyticsProtocol = resolve()
    
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
