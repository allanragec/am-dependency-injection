//
//  Container.swift
//  TestsWithDependencyContainer
//
//  Created by Allan Barbosa De Melo on 27/02/24.
//

import Foundation

@objc
public protocol DependencyInjection {
    static func inject()
}

@objc
public protocol ResolverProtocol {
    static var resolver: DependencyResolver { get }
}

public typealias ContainerResolverPublic = ContainerResolver & ResolverProtocol

@objc
public protocol ContainerResolverProtocol {
    func checkIfDependenciesCanBeResolved() throws
}

open class ContainerResolver: NSObject, ContainerResolverProtocol {
    public let resolver: DependencyResolver
    
    public required init(resolver: DependencyResolver) {
        self.resolver = resolver
    }
    
    private func checkDependency(_ dependency: DependencyItem, resolver: DependencyResolver) throws {
        let contains = resolver.dependenciesBag.keys.contains { registeredDependency in
            registeredDependency.contains(dependency.propertyType)
        }
        if !contains {
            let isGlobal = isGlobalDependency(dependency)
            if isGlobal {
                throw DependenciesError.GlobalDependencyNotRegistered(
                    property: dependency.propertyName,
                    type: dependency.propertyType,
                    in: String(reflecting: self)
                )
            } else {
                throw DependenciesError.LocalDependencyNotRegistered(
                    property: dependency.propertyName,
                    type: dependency.propertyType,
                    in: String(reflecting: self)
                )
            }
        }
    }
    
    private func isGlobalDependency(_ dependency: DependencyItem) -> Bool {
        let globalDependencies = globalDependencies()
        
        return globalDependencies.contains { globalDependency in
            "\(type(of: globalDependency))".contains(dependency.propertyType)
        }
    }
    
    func getResolver(_ dependency: DependencyItem) -> DependencyResolver {
        return isGlobalDependency(dependency) ?
            DependencyResolver.global :
            self.resolver
    }
    
    public func checkIfDependenciesCanBeResolved() throws {
        print("checkAllContainers inside on \(self)")
#if DEBUG
        for dependency in propertyTypes() {
            let resolver = getResolver(dependency)
            try checkDependency(dependency, resolver: resolver)
        }
#endif
    }
    
    func propertyTypes() -> [DependencyItem] {
        let dependencies = Mirror(reflecting: self).children
            .filter { $0.label != "resolver" }
            .compactMap { DependencyItem(propertyName: $0.label, propertyType: "\(type(of: $0.value))") }
        
        return dependencies
    }
    
    open func globalDependencies() -> [Any.Type] { [] }
    
    public func safelyResolve<Dependency>() -> Dependency? {
        return resolver.safelyResolve()
    }

    public func resolve<Dependency>() -> Dependency {
        return resolver.resolve()
    }
}

enum DependenciesError: Error {
    case LocalDependencyNotRegistered(
        property: String,
        type: String,
        in: String
    )
    case GlobalDependencyNotRegistered(
        property: String,
        type: String,
        in: String
    )
}

struct DependencyItem {
    let propertyName: String
    let propertyType: String
    
    init(propertyName: String?, propertyType: String) {
        self.propertyName = String((propertyName ?? "").split(separator: "_").last ?? "")
        self.propertyType = propertyType.replacingOccurrences(of: "Optional<", with: "")
            .replacingOccurrences(of: ">", with: "")
    }
}
