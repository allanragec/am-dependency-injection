//
//  SecurityManagerResolver.swift
//  SecurityManager
//
//  Created by Allan Melo on 09/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AMDependencyInjection

class SecurityManagerResolver: DependencyResolver {
    static let shared: SecurityManagerResolver = .init()
    private override init() {}
}
