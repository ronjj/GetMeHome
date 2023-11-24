//
//  ContentView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//

import SwiftUI

//Add some protection that origin and arrival destination can't be the same
var locations: [String] = ["Ithaca", "New York"]


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
    
        VStack {
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
            .padding()
            Button("Search") {
//
            }
//            MARK: Disable button if some conditions are violated
            .buttonStyle(.bordered)
            .tint(.indigo)
        }
    }
    
    private var listOfTrips: some View {
        List(MockData.mockTrips, id: \.bus_service) { trip in
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




