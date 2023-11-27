//
//  ListView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/25/23.
//

import SwiftUI

struct TripListView: View {
    
    var trips: [Trip]?
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
                VStack(alignment: .center) {
                    Text("No Results Found :( ")
                        .bold()
                        .font(.headline)
                    Text("Check Again Later")
                }
                Spacer()
            }
        }
        
        // Trips Array is Emtpy
        else {
            // User did not search yet
            if !clickedSearch {
            }
                Spacer()
                VStack(alignment: .center) {
                    Text("Search For Trips")
                        .bold()
                        .font(.headline)
                    Text("Select A Date, Bus Service, Origin, and Destination")
                        .multilineTextAlignment(.center)
                }
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
                        TripRowView(date: trip.date, price: trip.price, arrivalTime: trip.arrivalTime, arrivalLocation: trip.arrivalLocation, departureTime: trip.departureTime, departureLocation: trip.departureLocation, busService: trip.busService, nonStop: trip.nonStop)
                    }
                }
            }
            
            Section("Rest of Trips") {
                ForEach(trips![1...(trips!.count-1)] , id: \.randomNum) { trip in
                    NavigationLink(value: trip) {
                        TripRowView(date: trip.date, price: trip.price, arrivalTime: trip.arrivalTime, arrivalLocation: trip.arrivalLocation, departureTime: trip.departureTime, departureLocation: trip.departureLocation, busService: trip.busService, nonStop: trip.nonStop)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: Trip.self) { trip in
            TripDetailView(trip: trip)
        }
    }
    
    private var singleResultList: some View {
        List(trips! , id: \.randomNum) { trip in
            NavigationLink(value: trip) {
                TripRowView(date: trip.date, price: trip.price, arrivalTime: trip.arrivalTime, arrivalLocation: trip.arrivalLocation, departureTime: trip.departureTime, departureLocation: trip.departureLocation, busService: trip.busService, nonStop: trip.nonStop)
            }
        }
        
        .listStyle(.plain)
        .navigationDestination(for: Trip.self) { trip in
            TripDetailView(trip: trip)
        }
    }
}

