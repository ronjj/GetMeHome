//
//  MockData.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import Foundation

class MockData {
    
    static let mockTrips: [Trip] = [
        Trip(date: "2023-12-10", price: 35.99, arrivalTime: "13:05", arrivalLocation: "New York", departureTime: "08:30", departureLocation: "Ithaca", busService: "FlixBus", nonStop: "N/A"),
        Trip(date: "2023-12-10", price: 35.99, arrivalTime: "13:05", arrivalLocation: "New York", departureTime: "08:30", departureLocation: "Ithaca", busService: "OurBus", nonStop: "N/A"),
        Trip(date: "2023-12-10", price: 35.99, arrivalTime: "13:05", arrivalLocation: "New York", departureTime: "08:30", departureLocation: "Ithaca", busService: "MegaBus", nonStop: "N/A")
        
    ]
}
