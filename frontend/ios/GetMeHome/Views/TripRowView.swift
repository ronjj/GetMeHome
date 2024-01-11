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
        VStack(alignment: .leading, spacing: 5) {
            Text("$\(price, specifier: "%.2f")")
                .fontWeight(.bold)
            
            HStack (spacing: 2) {
                Image(systemName: "clock")
                Text(departureTime)
                Image(systemName: "arrow.right")
                Text(arrivalTime)
            }
            
            HStack (spacing:  2) {
                Image(systemName: "building")
                Text(departureLocation.prefix(20))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.trailing)
                Image(systemName: "arrow.right")
                Text(arrivalLocation.prefix(20))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.trailing)
            }
           
            if nonStop == "False" {
                HStack {
                    BusLabel(busService: busService)
                    BusLabel(busService: "indirect")
                }
            }
            else {
                BusLabel(busService: busService)
            }
        }
    }
}


