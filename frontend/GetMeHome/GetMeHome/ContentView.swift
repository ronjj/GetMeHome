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
    @State private var tapped = false
    
    
//    selectedTime = earlestDepartureTime
    @State private var selectedTime = Date()
    @State private var latestArrivalTime = Date()
    @State private var presentSheet = false
    @State private var minTimeToggle = false
    @State private var latestArrivalTimeToggle = false
    
    
    //    ViewModel and Query Info
    @State private var trips: [Trip]?
    var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationStack(path: $path) {
            HStack {
                dateAndLocationPickers
                    .padding(.bottom, 10)
                    .navigationTitle("GetMeHome")
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented:  $presentSheet) {
                        print("Sheet dismissed!")
                    } content: {
                        NavigationStack{
                            SheetView(minTimeToggle: $minTimeToggle, presentSheet: $presentSheet, latestArrivalTimeToggle: $latestArrivalTimeToggle)
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
                TripListView(trips: trips, clickedSearch: $clickedSearch)
                
            }
        }
        .ignoresSafeArea()
        .padding()
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
                
                //                fix on change of date not working
                
                Task {
                    isLoading = true
                    do {
                        trips = try await viewModel.getTrips(from: viewModel.locationQueryMap[selectedDeparture] ?? "new_york", to: viewModel.locationQueryMap[selectedArrival] ?? "ithaca", on: newDateString, bus: viewModel.convertForQuery(value: selectedService), minTime: (minTimeToggle ? selectedTime : Date.init(timeIntervalSince1970: 0)), latestArrival: (latestArrivalTimeToggle ? latestArrivalTime : Date.init(timeIntervalSince1970: 0)))
                        isLoading = false
                        clickedSearch = true
                        
                        //
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
                    tapped.toggle()
                    
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
            
            if minTimeToggle {
                DatePicker("Pick Earilest Departure Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .tint(.purple)
            }
            
            if latestArrivalTimeToggle {
                DatePicker("Pick Latest Arrival Time", selection: $latestArrivalTime, displayedComponents: .hourAndMinute)
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

struct SheetView: View {
    
    @Binding var minTimeToggle: Bool
    @Binding var presentSheet: Bool
    @Binding var latestArrivalTimeToggle: Bool
    
    var body: some View {
        VStack{
            Toggle("Set Earliest Departure Time", isOn: $minTimeToggle)
                .tint(.purple)
            Toggle("Set Latest Arrival Time", isOn: $latestArrivalTimeToggle)
                .tint(.purple)
            Spacer()
        }
        .padding()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Close"){
                    presentSheet = false
                }
                .tint(.purple)
            }
        }
    }
}



