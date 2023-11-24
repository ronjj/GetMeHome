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
            List {
                Section("Date") {
                    Text("\(trip.date)")
                }
                Section("Time") {
                    Text("\(trip.departure_time_string) - \(trip.arrival_time_string)")
                }
                Section("Price") {
                    Text("$\(trip.price, specifier: "%.2f")")
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
            //                MARK: Implement
            Button("Buy On \(trip.bus_service) Website"){
                
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }


