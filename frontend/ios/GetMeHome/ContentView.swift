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
    @State private var selectedService = "All"
    @State private var selectedDeparture = "Ithaca"
    @State private var earliestDepartureTime = Date()
    @State private var earliestDepartureTimeToggle = false
    @State private var selectedArrival = "New York"
    @State private var latestArrivalTime = Date()
    @State private var latestArrivalTimeToggle = false
    @State private var switchOriginAndDestinationButtonClicked = false
    @State private var clickedSearch = false
    @State private var isLoading = false
    @State private var presentSheet = false
    
    //    ViewModel and Query Info
    @State private var trips: [Trip]?
    @State private var discountCodes: [Discount]?
    
    var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            HStack {
                dateAndLocationPickers
                    .padding(.bottom, 10)
                    .navigationTitle("GetMeHome")
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented:  $presentSheet) {
                        //
                    } content: {
                        NavigationStack{
                            SettingsView(minTimeToggle: $earliestDepartureTimeToggle, presentSheet: $presentSheet, latestArrivalTimeToggle: $latestArrivalTimeToggle, busService: $selectedService)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            toolBarHeader
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            toolBarSettingsIcon
                        }
                    }
            }
            
            if isLoading {
                LoadingView()
            } else {
                TripListView(trips: trips, discountCodes: discountCodes, clickedSearch: $clickedSearch)
                
            }
        }
        .ignoresSafeArea()
        .padding()
    }
}


extension ContentView {
    private var searchAndBusPicker: some View {
        
        
        Button {
            //           Converting Date From:  2023-11-24 21:51:35 +0000
            //           To: 11-24-2023
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let newDateString = formatter.string(from: selectedDate)
            
            Task {
                isLoading = true
                do {
                    trips = try await viewModel.getTrips(
                        from: viewModel.locationQueryMap[selectedDeparture] ?? "new_york",
                        to: viewModel.locationQueryMap[selectedArrival] ?? "ithaca",
                        on: newDateString,
                        bus: viewModel.convertForQuery(value: selectedService))
                    
                    discountCodes = try await viewModel.getDiscountCodes(
                        from: viewModel.locationQueryMap[selectedDeparture] ?? "new_york",
                        to: viewModel.locationQueryMap[selectedArrival] ?? "ithaca",
                        on: newDateString,
                        bus: viewModel.convertForQuery(value: selectedService))
                    
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
        } label: {
            Text("Search")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .padding(.horizontal)
        .tint(.indigo)
        .disabled(selectedDeparture == selectedArrival || selectedService == "" || isLoading)
           
           
        
    }
    
    private var dateAndLocationPickers: some View {
        VStack {
            HStack{
                DatePicker("Trip  Date", selection: $selectedDate, in:Date.now...viewModel.calculateDateRange(), displayedComponents: .date)
                    .labelsHidden()
                    .tint(.purple)
                Menu(selectedDeparture) {
                    Button("Ithaca") {
                        selectedDeparture = "Ithaca"
                    }
                    Button("New York") {
                        selectedDeparture = "New York"
                    }
                }
                .tint(.purple)
                Button {
                    var tempLocation = ""
                    tempLocation = selectedDeparture
                    selectedDeparture = selectedArrival
                    selectedArrival = tempLocation
                    switchOriginAndDestinationButtonClicked.toggle()
                    
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                        .scaleEffect(0.8)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                
                Menu(selectedArrival) {
                    Button("Ithaca") {
                        selectedArrival = "Ithaca"
                    }
                    Button("New York") {
                        selectedArrival = "New York"
                    }
                }
                .padding(.horizontal, 0)
                .tint(.purple)
            }
            .padding()
            searchAndBusPicker
            
            if earliestDepartureTimeToggle {
                DatePicker("Earilest Departure Time", selection: $earliestDepartureTime, displayedComponents: .hourAndMinute)
                    .tint(.purple)
            }
            
            if latestArrivalTimeToggle {
                DatePicker("Latest Arrival Time", selection: $latestArrivalTime, displayedComponents: .hourAndMinute)
                    .tint(.purple)
            }
        }
    }
    
    private var toolBarHeader: some View {
        Text("GetMeHome")
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
    
    private var toolBarSettingsIcon: some View {
        Button {
            presentSheet = true
        } label: {
            Image(systemName: "gear")
        }
        .tint(.purple)
    }
}





