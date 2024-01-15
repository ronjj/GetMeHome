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
    @FetchRequest(sortDescriptors: []) var savedTrips: FetchedResults<SavedTrip>
    @State private var alreadySavedAlert = false
    
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
                if toggleLogic(trip: trip, isFavorite: isFavorite) == .notInSavedNotFavorite {
                    isFavorite = true
                    DataContrller().addSavedTrip(arrivalLocation: trip.arrivalLocation, arrivalTime: trip.arrivalTime, busService: trip.busService, date: trip.date, departureLocation: trip.departureLocation, departureTime: trip.departureTime, id:trip.randomNum , nonStop: trip.nonStop, price: trip.price, ticketLink: trip.ticketLink, context: managedObjectContext)
                } else if toggleLogic(trip: trip, isFavorite: isFavorite) == .inSavedAndFavorite {
//                  NOTE: Find the savedTrips with the same ID as the trip in the row and remove it from the array
//                    then save the savedTrips array
                    isFavorite = false
                    savedTrips.filter { $0.id == trip.randomNum }.forEach(managedObjectContext.delete)
                    DataContrller().save(context: managedObjectContext)
                } else if toggleLogic(trip: trip, isFavorite: isFavorite) == .notInSavedFavorite {
                    isFavorite = false
                } else {
//                    inSavedAndNotFavorite
                    alreadySavedAlert = true
                }
                
            } label : {
                Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
            }
            .tint(isFavorite ? .purple : .gray)
            .buttonStyle(.bordered)
        }
        .alert(isPresented: $alreadySavedAlert) {
            Alert(title: Text("Trip Already Saved"),
                  message: Text("This trip is already saved"),
                  dismissButton: .default(Text("Got it!")))
        }
    }
    
    func toggleLogic(trip: Trip, isFavorite: Bool) -> ReturnType {
        //      Check if there are any  savedTrips with this ID
        
        //        if the trip is not in the list and isFavorite == false
        if savedTrips.filter({ $0.id == trip.randomNum }).isEmpty && isFavorite == false {
            return .notInSavedNotFavorite
            //      if the trip is IN the saved list and is favorite  == false
        } else if !savedTrips.filter({ $0.id == trip.randomNum }).isEmpty && isFavorite == false {
            return .inSavedNotFavorite
        } else if savedTrips.filter({ $0.id == trip.randomNum }).isEmpty && isFavorite == true {
            return .notInSavedFavorite
        } else {
            return .inSavedAndFavorite
        }
    }
}

enum ReturnType {
    case inSavedAndFavorite
    case inSavedNotFavorite
    case notInSavedFavorite
    case notInSavedNotFavorite
}

