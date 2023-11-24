//
//  ViewModel.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import Foundation
import Observation



@Observable class ViewModel {
    var trips: [Trip] = []
    
    func getTrips(from departureLocation: String, to arrivalLocation: String, on date: String) async throws -> [Trip] {
//        MARK: be able to use custom dep_loc, arr_loc, and date for url
        let endpoint = "http://127.0.0.1:5000/flix/12-20-2023/new_york/ithaca"
        
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
            throw TripError.invalidData
        }
        
    }
}

enum TripError: Error {
    case invalidURL
    case invalidReponse
    case invalidData
}
