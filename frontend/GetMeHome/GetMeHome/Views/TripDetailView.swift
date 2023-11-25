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
                    Text("\(trip.departureTime) - \(trip.arrivalTime)")
                }
                Section("Price") {
                    Text("$\(trip.price, specifier: "%.2f")")
                }
                Section("Departure") {
                    Text("\(trip.departureLocation)")
                }
                Section("Destination") {
                    Text("\(trip.arrivalLocation)")
                }
                Section("Bus Service") {
                    Text("\(trip.busService)")
                }
                
            }
            .listStyle(.plain)
            Button("Buy On \(trip.busService) Website"){
//                  MARK: Implement
//                open in safari maybe i guess 

            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }


