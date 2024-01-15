//
//  AnalyticsManager.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/14/24.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseAnalyticsSwift


final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    private init() { }
    
    func logEvent(name: String, params: [String:Any]? = nil) {
        Analytics.logEvent(name, parameters: params)
    }
    
    func setUserId(userId: String) {
        Analytics.setUserID(userId)
    }
    
    func setUserProperty(value: String?, property: String) {
        Analytics.setUserProperty(value, forName: property)
    }
}
