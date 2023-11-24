//
//  Trip.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI

struct Trip: Hashable {
    let date: String
    let price: Float
    let arrival_time: String
    let arrival_location: String
    let departure_time: String
    let departure_location: String
    let bus_service: String
    let non_stop: String
}
