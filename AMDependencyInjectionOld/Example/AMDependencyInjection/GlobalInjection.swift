//
//  GlobalInjection.swift
//  Analytics
//
//  Created by Allan Melo on 10/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AMDependencyInjection
import FeatureFlag
import FeatureFlagAPI

class GlobalInjection: DependencyInjection {
    static func inject() {
        DependencyResolver.global
            .whenFindProtocol(FeatureFlagServiceProtocol.self, returns: { FeatureFlagService() })
    }
}
