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
        DO NOT DELETE THIS INFO:
        Application Name: \(Bundle.main.displayName)
        iOS: \(UIDevice.current.systemVersion)
        Device Model: \(UIDevice.current.modelName)
        App Version: \(Bundle.main.appVersion)
        App Build: \(Bundle.main.appBuild)
        \(messageHeader)
    --------------------------------------
    """
    }
    
    func send(openURL: OpenURLAction) {
        let gmailUrl =  "googlegmail://co?to=\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        let outlookUrl =  "ms-outlook://compose?to=\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        let yahooMail =  "ymail://mail/compose?to=\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        let sparkUrl =  "readdle-spark://compose?recipient=\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        let defaultUrl =  "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
        
        
        
        
        guard let gmailUrl = URL(string: gmailUrl) else {return}
        openURL(gmailUrl) { accepted in
            if !accepted {
                print("""
                This device does not support email
                \(body)
                """
                )
            }
        }
        
        guard let outlookUrl = URL(string: outlookUrl) else {return}
        openURL(outlookUrl) { accepted in
            if !accepted {
                print("""
                This device does not support email
                \(body)
                """
                )
            }
        }
        
        guard let yahooMail = URL(string: yahooMail) else {return}
        openURL(yahooMail) { accepted in
            if !accepted {
                print("""
                This device does not support email
                \(body)
                """
                )
            }
        }
        
        guard let sparkUrl = URL(string: sparkUrl) else {return}
        openURL(sparkUrl) { accepted in
            if !accepted {
                print("""
                This device does not support email
                \(body)
                """
                )
            }
        }
        
        guard let defaultUrl = URL(string: defaultUrl) else {return}
        openURL(defaultUrl) { accepted in
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
