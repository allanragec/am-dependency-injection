//
//  DependencyInjection.swift
//  Analytics
//
//  Created by Allan Melo on 10/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import AMDependencyInjection

class DependencyInjectionAnalytics: DependencyInjection {
    static func inject() {
        AnalyticsResolver.shared
            .whenFindProtocol(FirebaseAnalyticsProtocol.self, returns: { FirebaseAnalytics() })
    }
}
