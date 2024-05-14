//
//  FeatureFlagServiceProtocol.swift
//  FeatureFlagAPI
//
//  Created by Allan Melo on 09/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

public protocol HasFeatureFlagService {
    var featureFlagService: FeatureFlagServiceProtocol { get }
}

public protocol FeatureFlagServiceProtocol {}
