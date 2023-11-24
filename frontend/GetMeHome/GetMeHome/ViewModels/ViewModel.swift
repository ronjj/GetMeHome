//
//  ViewModel.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import Foundation
import Observation

let json = """
{
   "trips":[
      {
         "py/object":"bus_routes.Trip",
         "date":"2023-12-15",
         "price":40.99,
         "arrival_time":"23:35",
         "arrival_location":"New York",
         "departure_time":"19:15",
         "departure_location":"Ithaca",
         "bus_service":"FlixBus",
         "non_stop":"N/A"
      },
      {
         "py/object":"bus_routes.Trip",
         "date":"2023-12-15",
         "price":42.5,
         "arrival_time":"16:30:00",
         "arrival_location":"Coach USA Ithaca/Binghamton Bus Stop - Gate 401 - Port Authority Bus Terminal",
         "departure_time":"11:30:00",
         "departure_location":"North Campus Bus Stop - Jessup Rd - Outside the Robert Purcell Community Center",
         "bus_service":"MegaBus",
         "non_stop":"N/A"
      },
      {
         "py/object":"bus_routes.Trip",
         "date":"2023-12-15",
         "price":42.5,
         "arrival_time":"16:30:00",
         "arrival_location":"Coach USA Ithaca/Binghamton Bus Stop - Gate 401 - Port Authority Bus Terminal",
         "departure_time":"11:35:00",
         "departure_location":"West Campus Bus Stop - 240 West Avenue - By the Bakers Flagpole",
         "bus_service":"MegaBus",
         "non_stop":"N/A"
      }
    ]
}
"""


@Observable class ViewModel {
    var trips: [Trip] = []
    
    func fetchTrips(departureLocation: String, arrivalLocation: String) {
        print("hello")
    }
}
