//
//  Trip.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI

struct TripWrapper: Codable {
    let trips: [Trip]
}

struct Trip: Hashable, Codable {
    let randomNum: Int
    let date: String
    let price: Float
    let arrivalTime: String
    let arrivalLocation: String
    let departureTime: String
    let departureLocation: String
    let busService: String
    let nonStop: String
    let ticketLink: String
    let intermediateCount: Int
    let intermediateStations: [String]
}


