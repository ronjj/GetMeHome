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
    @State private var selectedArrival = "NYC"
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
    @State private var removeTransfersToggle = false
    
    //    ViewModel and Query Info
    @State private var trips: [Trip]?
    @State private var discountCodes: [Discount]?
    
    var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                VStack(alignment: .center) {
                    Text("GetMeHome")
                        .font(.title)
                        .fontWeight(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 0)
             
                DateAndLocationPickerView(
                    selectedDeparture: $selectedDeparture,
                    selectedArrival: $selectedArrival,
                    switchOriginAndDestinationButtonClicked: $switchOriginAndDestinationButtonClicked,
                    selectedDate: $selectedDate)
                    .padding(.bottom, 10)
                   
                SearchButton(trips: $trips,
                             discountCodes: $discountCodes,
                             selectedDate: $selectedDate,
                             earliestDepartureTime: $earliestDepartureTime,
                             latestArrivalTime: $latestArrivalTime,
                             selectedService: $selectedService,
                             selectedDeparture: $selectedDeparture,
                             selectedArrival: $selectedArrival,
                             selectServiceToggle: $selectServiceToggle,
                             earliestDepartureTimeToggle: $earliestDepartureTimeToggle,
                             isLoading: $isLoading,
                             removeTransfersToggle: $removeTransfersToggle,
                             latestArrivalTimeToggle: $latestArrivalTimeToggle,
                             clickedSearch: $clickedSearch)
                
                FilterRowView(
                    minDepartureTimeSelected: $earliestDepartureTimeToggle,
                    latestArrivalTimeSelected: $latestArrivalTimeToggle,
                    chooseBusServiceSelected: $selectServiceToggle,
                    includeTransfersSelected: $removeTransfersToggle)
                    .padding(.top)
                
                if earliestDepartureTimeToggle {
                    DatePicker("Earliest Departure Time",
//                               Need complicated binding so I can make earliestDeparture nil
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
                
            if isLoading {
                LoadingView()
            } else {
                TripListView(trips: trips, discountCodes: discountCodes, clickedSearch: $clickedSearch)
            }
        }
        .ignoresSafeArea()
        .padding()
        .navigationTitle("GetMeHome")
        
    }
}

