//
//  TripRowView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI

struct TripRowView: View {
    var date: String
    var price: Float
    var arrival_time: String
    var arrival_location: String
    var departure_time: String
    var departure_location: String
    var bus_service: String
    var non_stop: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(departure_time)
                Image(systemName: "arrow.forward")
                Text(arrival_time)
            }
            Text("\(price, specifier: "%.2f")")
            HStack{
                Text(departure_location)
                Image(systemName: "arrow.forward")
                Text(arrival_location)
            }
            BusLabel(busService: bus_service)
        }
    }
}

struct BusLabel: View {
    var busService: String
    
    var body: some View {
        switch busService {
        case "flixbus":
            Button("Flix Bus") {}
            .buttonStyle(.bordered)
            .tint(.blue)
        case "OurBus":
            Button("Our Bus") {}
            .buttonStyle(.bordered)
            .tint(.green)
        case "Mega":
            Button("Mega Bus") {}
                .buttonStyle(.bordered)
                .tint(.red)
        default:
            Text("No Bus Service")
        }
    }
}
