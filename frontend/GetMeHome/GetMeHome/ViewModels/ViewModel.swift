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
    let backupLinkMap = ["OurBus":"https://ourbus.com", "MegaBus":"https://us.megabus.com", "FlixBus":"https://flixbus.com"]
    
    func calculateDateRange() -> Date {
        let currentDate = Date()
        var dateComponent = DateComponents()
        
        dateComponent.month = 2
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        //        print("Current date is: \(currentDate)")
        return futureDate!
    }
    
    func convertForQuery(value string: String) -> String {
        let queryMap = ["All": "all", "OurBus":"our", "MegaBus":"mega", "FlixBus":"flix"]
        return queryMap[string] ?? "all"
    }
    
    func getTrips(from departureLocation: String, to arrivalLocation: String, on date: String, bus: String, minTime: Date) async throws -> [Trip] {
//        let endpoint = "https://get-me-home.onrender.com/\(bus)/\(date)/\(departureLocation)/\(arrivalLocation)"
        let endpoint = "http://127.0.0.1:5000/\(bus)/\(date)/\(departureLocation)/\(arrivalLocation)"
        
        guard let url = URL(string: endpoint) else {
            throw TripError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw TripError.invalidReponse
        }
        

        var results_list = [Trip]()
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
//                "hh:mma"
//              TimeIntervalSince1970 = 0 is basically the only way to set a date = 0
//            If a min time was selected, filter results
                if minTime != Date.init(timeIntervalSince1970: 0) {
                    let formatter = DateFormatter()
                    var results = try decoder.decode([Trip].self, from: data)
                    formatter.dateFormat = "hh:mma"
                    print("results before: \(results.count)")
                    let minTimeString = formatter.string(from: minTime)
                    results_list = results.filter { formatter.date(from: $0.departureTime) ?? Date.now >=  formatter.date(from: minTimeString)! }
                    print("results after: \(results_list.count)")
//                Else, return all results
                } else {
                    results_list = try decoder.decode([Trip].self, from: data)
                }
            
            return results_list
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
