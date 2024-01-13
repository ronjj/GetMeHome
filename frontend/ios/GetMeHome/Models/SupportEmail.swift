//
//  SupportEmail.swift
//  Team Sports
//
//  Created by Stewart Lynch on 2022-01-03.
//

import UIKit
import SwiftUI

struct SupportEmail {
    let toAddress: String
    let subject: String
    let messageHeader: String
    var data: Data?
    var body: String {"""
        DO NOT DELETE THIS INFO:\n
        Application Name: \(Bundle.main.displayName)
        iOS: \(UIDevice.current.systemVersion)\n
        Device Model: \(UIDevice.current.modelName)\n
        App Version: \(Bundle.main.appVersion)\n
        App Build: \(Bundle.main.appBuild)\n
        \(messageHeader)
    --------------------------------------
    """
    }
    
    func send(openURL: OpenURLAction) {
        let urlString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)"
        guard let url = URL(string: urlString) else { return }
        openURL(url) { accepted in
            if !accepted {
                print("""
                   This device does not support email
                   \(body)
                   """
                )
            }
        }
    }
}
