//
//  TripDetailView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI

struct TripDetailView: View {
    
    var trip: Trip
    var viewModel = ViewModel()
    
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
            
            Link("Buy on \(trip.busService) Website", destination: (URL(string: trip.ticketLink) ?? URL(string: viewModel.backupLinkMap[trip.busService]!))!)
                .buttonStyle(.bordered)
                .tint(.indigo)
            Spacer()
        }
    }


