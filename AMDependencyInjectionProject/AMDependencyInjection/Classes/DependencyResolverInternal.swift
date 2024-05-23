//
//  Resolver.swift
//  TestsWithDependencyContainer
//
//  Created by Allan Barbosa De Melo on 27/02/24.
//

import Foundation

@objc
open class DependencyResolverInternal: NSObject {
    public static let global: DependencyResolverInternal = .init()
    private(set) var dependenciesBag: [String: (type: Any.Type, resolver: () -> (Any))] = .init()
    public override init() {}
    
    @discardableResult
    public func whenFindProtocol<Dependency>(_ type: Dependency.Type, returns: @escaping () -> (Dependency)) -> Self {
        if let _ : Dependency = safelyResolve() {
            fatalError("Dependency \(String(reflecting: type)) is already registered")
        }
        dependenciesBag[String(reflecting: type)] = (type, returns)
        
        return self
    }
    
    public func safelyResolve<Dependency>() -> Dependency? {
        return dependenciesBag[String(reflecting: Dependency.self)]?.resolver() as? Dependency
    }

    public func resolve<Dependency>() -> Dependency {
        guard let dependency: Dependency = safelyResolve() else {
            fatalError("Could not resolve the dependency \(Dependency.self)")
        }

        return dependency
    }
    
    public func setupGlobal(injector: DependencyInjection) {
        
    }
}

//class GlobalDependencyResolver: DependencyResolverInternal, InjectionProtocol {
//    static var injector: DependencyInjection { get }
//}
//
//class GlobalInjection: DependencyInjection {
//    static func inject() {
//        DependencyResolverInternal.global
//            .whenFindProtocol(FeatureFlagServiceProtocol.self, returns: { FeatureFlagService() })
//    }
//}
