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


struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var selectedDate = Date()
    @State private var selectedDeparture = "Ithaca"
    @State private var selectedArrival = "New York"
    
    var body: some View {
        NavigationStack(path: $path) {
            dateAndLocationPickers
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
}
