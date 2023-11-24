//
//  ContentView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//

import SwiftUI

struct Trip: Hashable {
    let date: String
    let price: Float
    let arrival_time: String
    let arrival_location: String
    let departure_time: String
    let departure_location: String
    let bus_service: String
    let non_stop: String
}

//Add some protection that origin and arrival destination can't be the same
var locations: [String] = ["Ithaca", "New York"]

var trips: [Trip] = [.init(date: "2023-12-10", price: 35.99, arrival_time: "13:05", arrival_location: "New York", departure_time: "08:30", departure_location: "Ithaca", bus_service: "flixbus", non_stop: "N/A"),
                     .init(date: "2023-12-10", price: 35.99, arrival_time: "13:05", arrival_location: "New York", departure_time: "08:30", departure_location: "Ithaca", bus_service: "OurBus", non_stop: "N/A"),
                     .init(date: "2023-12-10", price: 35.99, arrival_time: "13:05", arrival_location: "New York", departure_time: "08:30", departure_location: "Ithaca", bus_service: "Mega", non_stop: "N/A")]


struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var selectedDate = Date()
    @State private var selectedDeparture = "Ithaca"
    @State private var selectedArrival = "New York"
    
    var body: some View {
        NavigationStack(path: $path) {
            dateAndLocationPickers
                .padding(.bottom, 10)
            
                List(trips, id: \.bus_service) { trip in
                    NavigationLink(value: trip) {
                        TripRowView(date: trip.date, price: trip.price, arrival_time: trip.arrival_time, arrival_location: trip.arrival_location, departure_time: trip.departure_time, departure_location: trip.departure_location, bus_service: trip.bus_service, non_stop: trip.non_stop)
                    }
                }
                .listStyle(.plain)
//                MARK: Make navigation destination for trip
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
        Text("Hello World")
    }
}

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
            Text("\(price)")
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
