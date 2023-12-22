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
    var arrivalTime: String
    var arrivalLocation: String
    var departureTime: String
    var departureLocation: String
    var busService: String
    var nonStop: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(departureTime)
                Image(systemName: "arrow.forward")
                Text(arrivalTime)
            }
            Text("$\(price, specifier: "%.2f")")
            HStack{
                Text(departureLocation)
                Image(systemName: "arrow.forward")
                Text(arrivalLocation)
            }
            BusLabel(busService: busService)
        }
    }
}

struct BusLabel: View {
    var busService: String
    
    var body: some View {
        switch busService {
        case "FlixBus":
            Button("FlixBus") {}
            .buttonStyle(.bordered)
            .tint(.blue)
        case "OurBus":
            Button("OurBus") {}
            .buttonStyle(.bordered)
            .tint(.green)
        case "MegaBus":
            Button("MegaBus") {}
                .buttonStyle(.bordered)
                .tint(.red)
        default:
            Text("No Bus Service")
        }
    }
}