//
//  ContentView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//

import SwiftUI

//Add some protection that origin and arrival destination can't be the same
var locations: [String] = ["Ithaca", "New York"]

var trips: [Trip] = [.init(date: "2023-12-10", price: 35.99, arrival_time: "13:05", arrival_location: "New York", departure_time: "08:30", departure_location: "Ithaca", bus_service: "FlixBus", non_stop: "N/A"),
                     .init(date: "2023-12-10", price: 35.99, arrival_time: "13:05", arrival_location: "New York", departure_time: "08:30", departure_location: "Ithaca", bus_service: "OurBus", non_stop: "N/A"),
                     .init(date: "2023-12-10", price: 35.99, arrival_time: "13:05", arrival_location: "New York", departure_time: "08:30", departure_location: "Ithaca", bus_service: "MegaBus", non_stop: "N/A")]


struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var selectedDate = Date()
    @State private var selectedDeparture = "Ithaca"
    @State private var selectedArrival = "New York"
    
    var body: some View {
        NavigationStack(path: $path) {
            Text("GetMeHome")
                .font(.largeTitle)
                .fontWeight(.heavy)
            dateAndLocationPickers
                .padding(.bottom, 10)
            
            listOfTrips
        }
        .padding()
        .navigationTitle("GetMeHome")
    }
}


extension ContentView {
    private var dateAndLocationPickers: some View {
        HStack{
            DatePicker("Trip  Date", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
            Menu(selectedDeparture) {
                Button("Ithaca") {
                    selectedDeparture = "Ithaca"
                }
                Button("New York") {
                    selectedDeparture = "New York"
                }
            }
            Image(systemName: "arrow.forward")
            Menu(selectedArrival) {
                Button("Ithaca") {
                    selectedArrival = "Ithaca"
                }
                Button("New York") {
                    selectedArrival = "New York"
                }
            }
        }
    }
    
    private var listOfTrips: some View {
        List(trips, id: \.bus_service) { trip in
            NavigationLink(value: trip) {
                TripRowView(date: trip.date, price: trip.price, arrival_time: trip.arrival_time_string, arrival_location: trip.arrival_location, departure_time: trip.departure_time_string, departure_location: trip.departure_location, bus_service: trip.bus_service, non_stop: trip.non_stop)
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: Trip.self) { trip in
            TripDetailView(trip: trip)
        }
    }
}




