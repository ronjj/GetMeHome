//
//  Ticket+Extension.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/15/24.
//

import Foundation

extension Ticket {
    var nameView: String {
        name ?? ""
    }
    
    var imageID: String {
        id ?? ""
    }
}
