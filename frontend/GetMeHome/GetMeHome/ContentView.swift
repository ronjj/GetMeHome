//
//  ContentView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var selectedDate = Date()
    @State private var selectedDeparture = "Ithaca"
    @State private var selectedArrival = "New York"
    @State private var trips: [Trip]?
    
    var queryMap = ["New York":"new_york", "Ithaca": "ithaca"]
    
    var viewModel = ViewModel()
    
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

//               Converting Date From:  2023-11-24 21:51:35 +0000
    //           To: 11-24-2023
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy"
                let newDateString = formatter.string(from: selectedDate)

                Task {
                    do {
                        trips = try await viewModel.getTrips(from: queryMap[selectedDeparture] ?? "new_york", to: queryMap[selectedArrival] ?? "ithaca", on: newDateString)
                        print(selectedDate)
                        
                    } catch TripError.invalidURL {
                        print("invalid url")
                    } catch TripError.invalidReponse {
                        print("invalid response")
                    } catch TripError.invalidData {
                        print("invalid data")
                    } catch {
                        print("unexpected erorr")
                    }
                }
            }
            .buttonStyle(.bordered)
            .tint(.indigo)
            .disabled(selectedDeparture == selectedArrival)
        }
    }
    
    private var listOfTrips: some View {
        List(trips ?? [], id: \.randomNum) { trip in
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




