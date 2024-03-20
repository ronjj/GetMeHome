//
//  ContentView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var requestFailedAlert: Bool = false
    
    //    User Selections
    @State private var selectedDate = Date()
    @State private var selectedDeparture = "Ithaca, NY"
    @State private var selectedArrival = "NYC"
    @State private var switchOriginAndDestinationButtonClicked = false
    @State private var clickedSearch = false
    @State private var isLoading = false
    
    //    Filtering
    @State private var presentFilterSheet = false
    @State private var earliestDepartureTimeLocal: Date? = nil
    @State private var earliestDepartureTimeToggle = false
    @State private var latestArrivalTimeLocal: Date? = nil
    @State private var latestArrivalTimeToggle = false
    @State private var selectedServiceLocal = "All"
    @State private var selectServiceToggle = false
    @State private var removeTransfersToggle = false
    @State private var maxPriceToggle = false
    @State private var maxPriceLocal: Double = 0.0
    
    //    AppStorage
    @AppStorage("earliestDepartureOnToggle") private var earliestDepartureOnToggle: Bool = false
    @AppStorage("latestArrivalOnToggle") private var latestArrivalOnToggle: Bool = false
    @AppStorage("setDefaultBusToggle") private var setDefaultBusToggle: Bool = false
    @AppStorage("earliestDepartureTime") private var earliestDepartureTime: Date = Date()
    @AppStorage("latestArrivalTime") private var latestArrivalTime: Date = Date()
    @AppStorage("selectedService") private var selectedService = "All"
    @AppStorage("removeTransfers") private var removeTransfers = false
    @AppStorage("departureLocationOnToggle") private var departureLocationOnToggle = false
    @AppStorage("departureLocation") private var departureLocation: String = "Ithaca"
    @AppStorage("arrivalLocationOnToggle") private var arrivalLocationOnToggle = false
    @AppStorage("arrivalLocation") private var arrivalLocation: String = "NYC"
    @AppStorage("maxPrice") private var maxPrice: Double = 0.0
    @AppStorage("maxPriceOnToggle") private var maxPriceOnToggle: Bool = false
    
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
                selectedDate: $selectedDate,
                isLoading: $isLoading)
            .padding(.bottom, 10)
            
            SearchButton(trips: $trips,
                         discountCodes: $discountCodes,
                         selectedDate: $selectedDate,
                         earliestDepartureTime: $earliestDepartureTimeLocal,
                         latestArrivalTime: $latestArrivalTimeLocal,
                         selectedService: $selectedServiceLocal,
                         selectedDeparture: $selectedDeparture,
                         selectedArrival: $selectedArrival,
                         maxPrice: $maxPriceLocal,
                         selectServiceToggle: $selectServiceToggle,
                         earliestDepartureTimeToggle: $earliestDepartureTimeToggle,
                         isLoading: $isLoading,
                         removeTransfersToggle: $removeTransfersToggle,
                         latestArrivalTimeToggle: $latestArrivalTimeToggle,
                         clickedSearch: $clickedSearch,
                         switchOriginAndDestinationButtonClicked: $switchOriginAndDestinationButtonClicked,
                         showSearchError: $requestFailedAlert,
                         maxPriceToggle: $maxPriceToggle,
                         presentFilterSheet: $presentFilterSheet)
            
            //                FilterRowView(
            //                    maxPriceSelected: $maxPriceToggle,
            //                    minDepartureTimeSelected: $earliestDepartureTimeToggle,
            //                    latestArrivalTimeSelected: $latestArrivalTimeToggle,
            //                    chooseBusServiceSelected: $selectServiceToggle,
            //                    includeTransfersSelected: $removeTransfersToggle,
            //                    isLoading: $isLoading)
            //                .padding(.top)
            
            if earliestDepartureTimeToggle {
                DatePicker("Earliest Departure Time",
                           //                               Need complicated binding so I can make earliestDeparture nil
                           selection: Binding<Date>(get: {self.earliestDepartureTimeLocal ?? Date()}, set: {self.earliestDepartureTimeLocal = $0}),
                           displayedComponents: .hourAndMinute)
                .tint(.purple)
                .disabled(isLoading ? true : false)
                .opacity(isLoading ? 0.25 : 1.0)
            }
            
            if latestArrivalTimeToggle {
                DatePicker("Latest Arrival Time",
                           selection: Binding<Date>(get: {self.latestArrivalTimeLocal ?? Date()}, set: {self.latestArrivalTimeLocal = $0}),
                           displayedComponents: .hourAndMinute)
                .tint(.purple)
                .disabled(isLoading ? true : false)
                .opacity(isLoading ? 0.25 : 1.0)
            }
            
            if selectServiceToggle {
                Picker("Choose A Bus Service", selection: $selectedServiceLocal) {
                    ForEach(viewModel.services, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.palette)
                .disabled(isLoading ? true : false)
                .opacity(isLoading ? 0.25 : 1.0)
            }
            if maxPriceToggle {
                HStack {
                    Text("Max Price")
                    Spacer()
                    Slider(value: $maxPriceLocal, in: 1...400, step: 1.0)
                    Text("$\(maxPriceLocal, specifier: "%.2f")")
                }
                .tint(.purple)
            }
        }
        .sheet(isPresented: $presentFilterSheet) {
            print("Sheet dismissed!")
        } content: {
            
            FilterScreen(isLoading: $isLoading,
                         earliestDepartureTimeLocal: $earliestDepartureTimeLocal,
                         depTimeFilter: $earliestDepartureTimeToggle,
                         maxPriceToggle: $maxPriceToggle,
                         maxPriceLocal: $maxPriceLocal,
                            selectedServiceLocal: $selectedServiceLocal,
                        selectServiceToggle: $selectServiceToggle)
            
        }
        .alert(isPresented: $requestFailedAlert) {
            Alert(title: Text("Search Error"),
                  message: Text("There was an error searching for trips. Try again later."),
                  dismissButton: .cancel())
        }
        .ignoresSafeArea()
        .padding()
        .analyticsScreen(name: "ContentView")
        .onAppear {
            if earliestDepartureOnToggle {
                earliestDepartureTimeToggle = true
                earliestDepartureTimeLocal = earliestDepartureTime
            }
            
            if latestArrivalOnToggle {
                latestArrivalTimeToggle = true
                latestArrivalTimeLocal = latestArrivalTime
            }
            
            if setDefaultBusToggle {
                selectServiceToggle = true
                selectedServiceLocal = selectedService
            }
            
            if removeTransfers {
                removeTransfersToggle = true
                removeTransfersToggle = removeTransfers
            }
            
            if arrivalLocationOnToggle {
                selectedArrival = arrivalLocation
            }
            
            if departureLocationOnToggle {
                selectedDeparture = departureLocation
            }
            
            if maxPriceOnToggle {
                maxPriceToggle = true
                maxPriceLocal = maxPrice
            }
        }
        
        if isLoading {
            LoadingView()
        } else {
            TripListView(trips: trips, discountCodes: discountCodes, clickedSearch: $clickedSearch)
        }   
    }
}

