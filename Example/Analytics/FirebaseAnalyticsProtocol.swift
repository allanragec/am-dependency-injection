//
//  FirebaseAnalyticsProtocol.swift
//  Analytics
//
//  Created by Allan Melo on 10/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

public protocol HasFirebaseAnalytics {
    var firebaseAnalytics: FirebaseAnalyticsProtocol { get }
}

public protocol FirebaseAnalyticsProtocol {}
