//
//  NetworkClientResolver.swift
//  NetworkClient
//
//  Created by Allan Melo on 10/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AMDependencyInjection

class NetworkClientResolver: DependencyResolver {
    static var injector: DependencyInjection { DependencyInjectionNetwork() }
    
    static let shared: NetworkClientResolver = .init()
    private override init() {}
}


