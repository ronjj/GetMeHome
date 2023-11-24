//
//  Trip.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI


public struct TripsCollectionResponse: Codable {
    public struct trips: Codable {
        
    }
    
}

struct Trip: Hashable, Codable {
    
    let date: String
    let price: Float
    let arrival_time: String
    var arrival_time_string: String {
        var toReturn = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        if let date = dateFormatterGet.date(from: arrival_time) {
            toReturn = dateFormatterPrint.string(from: date)
        } else {
           toReturn = "N/A"
        }
        return toReturn
    }
    
    let arrival_location: String
    let departure_time: String
    var departure_time_string: String {
        var toReturn = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        if let date = dateFormatterGet.date(from: departure_time) {
            toReturn = dateFormatterPrint.string(from: date)
        } else {
           toReturn = "N/A"
        }
        return toReturn
    }
    let departure_location: String
    let bus_service: String
    let non_stop: String
}


