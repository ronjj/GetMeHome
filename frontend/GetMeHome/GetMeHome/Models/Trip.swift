//
//  Trip.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI


struct Trip: Hashable, Codable {
    let date: String
    let price: Float
    let arrivalTime: String
    var arrivalTimeString: String {
        var toReturn = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        if let date = dateFormatterGet.date(from: arrivalTime) {
            toReturn = dateFormatterPrint.string(from: date)
        } else {
           toReturn = "N/A"
        }
        return toReturn
    }
    
    let arrivalLocation: String
    let departureTime: String
    var departureTimeString: String {
        var toReturn = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        if let date = dateFormatterGet.date(from: departureTime) {
            toReturn = dateFormatterPrint.string(from: date)
        } else {
           toReturn = "N/A"
        }
        return toReturn
    }
    let departureLocation: String
    let busService: String
    let nonStop: String
}


