//
//  TripRowView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI

struct TripRowView: View {
    var trip: Trip
    
    @State var isFavorite: Bool = false
    @Environment (\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text("$\(trip.price, specifier: "%.2f")")
                .fontWeight(.bold)
            
            HStack (spacing: 2) {
                Image(systemName: "clock")
                Text(trip.departureTime)
                Image(systemName: "arrow.right")
                Text(trip.arrivalTime)
            }
            
            HStack (spacing:  2) {
                Image(systemName: "building")
                Text(trip.departureLocation.prefix(20))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.trailing)
                Image(systemName: "arrow.right")
                Text(trip.arrivalLocation.prefix(20))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.trailing)
            }
           
            if trip.nonStop == "False" {
                HStack {
                    BusLabel(busService: trip.busService)
                    BusLabel(busService: "indirect")
                }
            }
            else {
                BusLabel(busService: trip.busService)
            }
            Button {
                AnalyticsManager.shared.logEvent(name: "TripRowView_FavoriteClicked")
                isFavorite.toggle()
                if isFavorite {
                    DataContrller().addSavedTrip(arrivalLocation: trip.arrivalLocation, arrivalTime: trip.arrivalTime, busService: trip.busService, date: trip.date, departureLocation: trip.departureLocation, departureTime: trip.departureTime, id:trip.randomNum , nonStop: trip.nonStop, price: trip.price, ticketLink: trip.ticketLink, context: managedObjectContext)
                }
                
            } label : {
                Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
            }
            .tint(isFavorite ? .purple : .gray)
            .buttonStyle(.bordered)
        }
    }
}


