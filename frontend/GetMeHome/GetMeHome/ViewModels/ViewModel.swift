//
//  ViewModel.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import Foundation
import Observation
import SwiftUI

@Observable class ViewModel {
    var trips: [Trip] = []
    let services = ["All", "OurBus", "MegaBus", "FlixBus"]
    let locationQueryMap = ["New York":"new_york", "Ithaca": "ithaca"]
    
    func calculateDateRange() -> Date {
        let currentDate = Date()
        var dateComponent = DateComponents()

        dateComponent.month = 2

        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)

        print("Current date is: \(currentDate)")
        return futureDate!
    }
    
    func convertForQuery(value string: String) -> String {
        let queryMap = ["All": "all", "OurBus":"our", "MegaBus":"mega", "FlixBus":"flix"]
        return queryMap[string] ?? "all"
    }
    
    func getTrips(from departureLocation: String, to arrivalLocation: String, on date: String, bus: String) async throws -> [Trip] {
        
//        MARK: be able to use custom dep_loc, arr_loc, and date for url
        let endpoint = "http://127.0.0.1:5000/\(bus)/\(date)/\(departureLocation)/\(arrivalLocation)"
        
        guard let url = URL(string: endpoint) else { 
            throw TripError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw TripError.invalidReponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            try trips = decoder.decode([Trip].self, from: data)
            return try decoder.decode([Trip].self, from: data)
        } catch {
            print(error.localizedDescription)
            throw TripError.invalidData
        }
    }
}

enum TripError: Error {
    case invalidURL
    case invalidReponse
    case invalidData
}
