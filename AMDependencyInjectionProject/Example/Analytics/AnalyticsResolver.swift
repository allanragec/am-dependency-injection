//
//  AnalyticsResolver.swift
//  Analytics
//
//  Created by Allan Melo on 09/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AMDependencyInjection

class AnalyticsResolver: DependencyResolver {
    static var injector: DependencyInjection { DependencyInjectionAnalytics() }
    static let shared: AnalyticsResolver = .init()
    private override init() {}
}
