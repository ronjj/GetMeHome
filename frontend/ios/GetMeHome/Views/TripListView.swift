//
//  ListView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/25/23.
//

import SwiftUI

struct TripListView: View {
    
    var trips: [Trip]?
    var discountCodes: [Discount]?

    @Binding var clickedSearch: Bool
    
    var body: some View {
// If Able to Unwrap trips
        if let trips {
            if trips.count > 2 {
                multipleResultsList
            }
            else if trips.count > 0 {
                singleResultList
            }
            else {
                Spacer()
                noResultsFound
                Spacer()
            }
        }
        
// Trips Array is Emtpy
        else {
            // User did not search yet
                Spacer()
                searchForTrips
                Spacer()
        }
    }
}

extension TripListView {
    private var multipleResultsList: some View {
//        Force unwrapping since this code is inside an if-let for trips array
        List {
            Text("\(trips!.count) Trips")
            Section("Cheapest Trip") {
                ForEach(trips![...0] , id: \.randomNum) { trip in
                    NavigationLink(value: trip) {
                        TripRowView(trip: trip)
                    }
                }
            }
            
            Section("Rest of Trips") {
                ForEach(trips![1...(trips!.count-1)] , id: \.randomNum) { trip in
                    NavigationLink(value: trip) {
                        TripRowView(trip: trip)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: Trip.self) { trip in
            TripDetailView(trip: trip, discountCodes: discountCodes ?? [])
        }
    }
    
    private var singleResultList: some View {
        List(trips! , id: \.randomNum) { trip in
            NavigationLink(value: trip) {
                TripRowView(trip: trip)
            }
        }
        
        .listStyle(.plain)
        .navigationDestination(for: Trip.self) { trip in
            TripDetailView(trip: trip, discountCodes: discountCodes ?? [])
        }
    }
    
    private var noResultsFound: some View {
        VStack(alignment: .center) {
            Text("No Results Found :( ")
                .bold()
                .font(.headline)
            Text("Check again later or adjust search settings")
        }
    }
    
    private var searchForTrips: some View {
        VStack(alignment: .center) {
            Text("Search For Trips")
                .bold()
                .font(.headline)
            Text("Select A Date, Departure Location, and Destination")
                .multilineTextAlignment(.center)
        }
    }
}
