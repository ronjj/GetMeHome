//
//  ContentView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    
    //    User Selections
    @State private var selectedDate = Date()
    @State private var selectedDeparture = "Ithaca"
    @State private var selectedArrival = "New York"
    @State private var clickedSearch = false
    @State private var selectedService = ""
    @State private var isLoading = false
    
    
    //    ViewModel and Query Info
    @State private var trips: [Trip]?
    var viewModel = ViewModel()

    
    var body: some View {
        NavigationStack(path: $path) {
            Text("GetMeHome")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            dateAndLocationPickers
                .padding(.bottom, 10)
            
            if isLoading {
                LoadingView()
            } else {
                TripListView(trips: trips, clickedSearch: $clickedSearch)
            }
        }
        .padding()
        .navigationTitle("GetMeHome")
        .toolbar {
            
        }
    }
}


extension ContentView {
    
    private var searchAndBusPicker: some View {
        HStack {
            Picker("Choose A Bus Service", selection: $selectedService) {
                ForEach(viewModel.services, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            
            Button("Search") {
//           Converting Date From:  2023-11-24 21:51:35 +0000
//           To: 11-24-2023
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd-yyyy"
                let newDateString = formatter.string(from: selectedDate)
                
                Task {
                    isLoading = true
                    do {
                        trips = try await viewModel.getTrips(from: viewModel.locationQueryMap[selectedDeparture] ?? "new_york", to: viewModel.locationQueryMap[selectedArrival] ?? "ithaca", on: newDateString, bus: viewModel.convertForQuery(value: selectedService))
                        print(selectedDate)
                        isLoading = false
                        clickedSearch = true
                        
                    } catch TripError.invalidURL {
                        print("invalid url")
                        isLoading = false
                    } catch TripError.invalidReponse {
                        print("invalid response")
                        isLoading = false
                    } catch TripError.invalidData {
                        print("invalid data")
                        isLoading = false
                    } catch {
                        print("unexpected erorr")
                        isLoading = false
                    }
                }
            }
            .buttonStyle(.bordered)
            .tint(.indigo)
            .disabled(selectedDeparture == selectedArrival || selectedService == "")
        }
    }
    
    private var dateAndLocationPickers: some View {
        VStack {
            HStack{
                DatePicker("Trip  Date", selection: $selectedDate, in:Date.now...viewModel.calculateDateRange(), displayedComponents: .date)
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
            
            searchAndBusPicker
            
        }
    }
}




