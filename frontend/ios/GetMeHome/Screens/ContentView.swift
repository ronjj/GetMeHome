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
    @State private var earliestDepartureTimeLocal: Date? = nil
    @State private var earliestDepartureTimeToggle = false
    @State private var latestArrivalTimeLocal: Date? = nil
    @State private var latestArrivalTimeToggle = false
    @State private var selectedServiceLocal = "All"
    @State private var selectServiceToggle = false
    @State private var removeTransfersToggle = false
    
    //    AppStorage
    @AppStorage("earliestDepartureOnToggle") private var earliestDepartureOnToggle: Bool = false
    @AppStorage("latestArrivalOnToggle") private var latestArrivalOnToggle: Bool = false
    @AppStorage("setDefaultBusToggle") private var setDefaultBusToggle: Bool = false
    @AppStorage("earliestDepartureTime") private var earliestDepartureTime: Date = Date()
    @AppStorage("latestArrivalTime") private var latestArrivalTime: Date = Date()
    @AppStorage("selectedService") private var selectedService = "All"
    @AppStorage("removeTransfers") private var removeTransfers = false
    
    //    ViewModel and Query Info
    @State private var trips: [Trip]?
    @State private var discountCodes: [Discount]?
    var viewModel = ViewModel()
    
    var body: some View {
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
                    selectedDate: $selectedDate)
                .padding(.bottom, 10)
                
                SearchButton(trips: $trips,
                             discountCodes: $discountCodes,
                             selectedDate: $selectedDate,
                             earliestDepartureTime: $earliestDepartureTimeLocal,
                             latestArrivalTime: $latestArrivalTimeLocal,
                             selectedService: $selectedServiceLocal,
                             selectedDeparture: $selectedDeparture,
                             selectedArrival: $selectedArrival,
                             selectServiceToggle: $selectServiceToggle,
                             earliestDepartureTimeToggle: $earliestDepartureTimeToggle,
                             isLoading: $isLoading,
                             removeTransfersToggle: $removeTransfersToggle,
                             latestArrivalTimeToggle: $latestArrivalTimeToggle,
                             clickedSearch: $clickedSearch, 
                             switchOriginAndDestinationButtonClicked: $switchOriginAndDestinationButtonClicked)
                
                FilterRowView(
                    minDepartureTimeSelected: $earliestDepartureTimeToggle,
                    latestArrivalTimeSelected: $latestArrivalTimeToggle,
                    chooseBusServiceSelected: $selectServiceToggle,
                    includeTransfersSelected: $removeTransfersToggle)
                .padding(.top)
                
                if earliestDepartureTimeToggle {
                    DatePicker("Earliest Departure Time",
                               //                               Need complicated binding so I can make earliestDeparture nil
                               selection: Binding<Date>(get: {self.earliestDepartureTimeLocal ?? Date()}, set: {self.earliestDepartureTimeLocal = $0}),
                               displayedComponents: .hourAndMinute)
                    .tint(.purple)
                }
                
                if latestArrivalTimeToggle {
                    DatePicker("Latest Arrival Time",
                               selection: Binding<Date>(get: {self.latestArrivalTimeLocal ?? Date()}, set: {self.latestArrivalTimeLocal = $0}),
                               displayedComponents: .hourAndMinute)
                    .tint(.purple)
                }
                
                if selectServiceToggle {
                    Picker("Choose A Bus Service", selection: $selectedServiceLocal) {
                        ForEach(viewModel.services, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.palette)
                }
            }
            .ignoresSafeArea()
            .padding()
            .analyticsScreen(name: "ContentView")
            .onAppear {
                if earliestDepartureOnToggle {
                    earliestDepartureTimeToggle = true
                    earliestDepartureTimeLocal = earliestDepartureTime
                } else {
                    earliestDepartureTimeToggle = false
                }
                
                if latestArrivalOnToggle {
                    latestArrivalTimeToggle = true
                    latestArrivalTimeLocal = latestArrivalTime
                } else {
                    latestArrivalTimeToggle = false
                }
                
                if setDefaultBusToggle {
                    selectServiceToggle = true
                    selectedServiceLocal = selectedService
                } else {
                    selectServiceToggle = false
                }
                
                if removeTransfers {
                    removeTransfersToggle = true
                    removeTransfersToggle = removeTransfers
                } else {
                    removeTransfersToggle = false
                }
            }
            
            if isLoading {
                LoadingView()
            } else {
                TripListView(trips: trips, discountCodes: discountCodes, clickedSearch: $clickedSearch)
            }
    }
}

