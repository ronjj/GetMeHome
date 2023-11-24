//
//  TripDetailView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI

struct TripDetailView: View {
    
    var trip: Trip
    
    var body: some View {
        VStack{
            List {
                Section("Time") {
                    Text("\(trip.departure_time) - \(trip.arrival_time)")
                }
                Section("Price") {
                    Text("\(trip.price)")
                }
                Section("Departure") {
                    Text("\(trip.departure_location)")
                }
                Section("Destination") {
                    Text("\(trip.arrival_location)")
                }
                Section("Bus Service") {
                    Text("\(trip.bus_service)")
                }
            }
            .listStyle(.plain)
        }
    }
}

