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
    @State private var switchOriginAndDestinationButtonClicked = false
    @State private var clickedSearch = false
    @State private var isLoading = false
    
//    Filtering
    @State private var earliestDepartureTime: Date? = nil
    @State private var earliestDepartureTimeToggle = false
    @State private var latestArrivalTime: Date? = nil
    @State private var latestArrivalTimeToggle = false
    @State private var selectedService = "All"
    @State private var selectServiceToggle = false
    
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
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            toolBarHeader
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
            print(selectedService)
            print(selectServiceToggle)
            
            Task {
                isLoading = true
                do {
                    
                    if !selectServiceToggle {
                        selectedService = "All"
                    }
                    
                    trips = try await viewModel.getTrips(
                        from: viewModel.locationQueryMap[selectedDeparture] ?? "new_york",
                        to: viewModel.locationQueryMap[selectedArrival] ?? "ithaca",
                        on: newDateString,
                        bus: viewModel.convertForQuery(value: selectedService))
                    
                    if earliestDepartureTimeToggle {
                        trips = viewModel.filterMinDepartureTime(tripsArray: trips ?? [], minTime: earliestDepartureTime!)
                    }
                    
                    if latestArrivalTimeToggle {
                        trips = viewModel.filterLatestArrivalTime(tripsArray: trips ?? [], latestArrival: latestArrivalTime!)
                    }
                    
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
           
            FilterRowView(
                minDepartureTimeSelected: $earliestDepartureTimeToggle, 
                latestArrivalTimeSelected: $latestArrivalTimeToggle,
                chooseBusServiceSelected: $selectServiceToggle)
           
            if earliestDepartureTimeToggle {
                DatePicker("Earliest Departure Time", 
                           selection: Binding<Date>(get: {self.earliestDepartureTime ?? Date()}, set: {self.earliestDepartureTime = $0}),
                           displayedComponents: .hourAndMinute)
                    .tint(.purple)
            }
            
            if latestArrivalTimeToggle {
                DatePicker("Latest Arrival Time", 
                           selection: Binding<Date>(get: {self.latestArrivalTime ?? Date()}, set: {self.latestArrivalTime = $0}),
                           displayedComponents: .hourAndMinute)
                    .tint(.purple)
            }
            
            if selectServiceToggle {
                Picker("Choose A Bus Service", selection: $selectedService) {
                    ForEach(viewModel.services, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.palette)
            }
        }
    }
    
    private var toolBarHeader: some View {
        Text("GetMeHome")
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
}





