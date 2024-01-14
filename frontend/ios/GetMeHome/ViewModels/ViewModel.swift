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

    let services = ["All", "OurBus", "MegaBus", "FlixBus"]
    let locationQueryMap = ["NYC":"new_york", "Ithaca": "ithaca", "Syracuse": "syracuse", "SYR Airport": "syr_airport"]
    let backupLinkMap = ["OurBus":"https://ourbus.com", "MegaBus":"https://us.megabus.com", "FlixBus":"https://flixbus.com"]
   
    func calculateDateRange() -> Date {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.month = 1
        dateComponent.day = 7
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        return futureDate!
    }
    
    func sameSearchParams(lastSearch: Dictionary<String,String>,
                          newSearch: Dictionary<String,String>) -> Bool {
        
        if lastSearch["from"] == newSearch["from"] &&
            lastSearch["to"] == newSearch["to"] &&
            lastSearch["on"] == newSearch["on"] {
            return true
        } else {
            return false
        }
    }
    
    func convertForQuery(value string: String) -> String {
        let queryMap = ["All": "all", "OurBus":"our", "MegaBus":"mega", "FlixBus":"flix"]
        return queryMap[string] ?? "all"
    }
    
//    MARK: GET Requests 
    func getTripsAndDiscounts(from departureLocation: String, to arrivalLocation: String, on date: String, bus: String) async throws -> ([Trip],[Discount]) {
//          let endpoint = "https://get-me-home.onrender.com/\(bus)/\(date)/\(departureLocation)/\(arrivalLocation)"
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
            let trips = try decoder.decode(TripWrapper.self, from: data)
            let discountCodes = try decoder.decode(DiscountWrapper.self, from: data)
            return (trips.trips, discountCodes.discountCodes)
        } catch {
            print(error.localizedDescription)
            throw TripError.invalidData
        }
    }
    
//    MARK: Filtering Requests
    func filterMinDepartureTime(tripsArray: [Trip], minTime: Date) -> [Trip] {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        print("results before min time filter: \(tripsArray.count)")
        let minTimeString = formatter.string(from: minTime)
        let newTripsArray = tripsArray.filter { formatter.date(from: $0.departureTime) ?? Date.now >=  formatter.date(from: minTimeString)! }
        print("results after min time filter: \(newTripsArray.count)")
        return newTripsArray
    }
    
    func filterLatestArrivalTime(tripsArray: [Trip], latestArrival: Date) -> [Trip] {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        print("results before latest arrival filter: \(tripsArray.count)")
        let latestArrivalTimeString = formatter.string(from: latestArrival)
        let newTripsArray = tripsArray.filter { formatter.date(from: $0.arrivalTime) ?? Date.now <=  formatter.date(from: latestArrivalTimeString)! }
        print("results after latest arrival filter: \(newTripsArray.count)")
        return newTripsArray
    }
    
//   includeTransfers parameter is included as inline documentation + additional clarity when calling function
    func filterTransfer(tripsArray: [Trip], includeTransfers: Bool) -> [Trip] {
        print("results before no transfer: \(tripsArray.count)")
        let newTripsArray = tripsArray.filter{ $0.nonStop == "True"}
        print("results after no transfer: \(newTripsArray.count)")
        return newTripsArray
    }
    
    func filterBus(tripsArray: [Trip], busService: String) -> [Trip] {
        print("results before latest arrival filter: \(tripsArray.count)")
        let newTripsArray = tripsArray.filter {$0.busService == busService}
        print("results after latest arrival filter: \(newTripsArray.count)")
        return newTripsArray
    }
}

enum TripError: Error {
    case invalidURL
    case invalidReponse
    case invalidData
}

