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
    @State private var showAdvancedOptions = false
    @State private var selectedTime = Date()
    
    
    //    ViewModel and Query Info
    @State private var trips: [Trip]?
    var viewModel = ViewModel()

    
    var body: some View {
        NavigationStack(path: $path) {
            Text("GetMeHome")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            HStack {
                dateAndLocationPickers
                    .padding(.bottom, 10)
            }
            
            if isLoading {
                LoadingView()
            } else {
                TripListView(trips: trips, clickedSearch: $clickedSearch)
                   
            }
        }
        .ignoresSafeArea()
        .padding()
        .navigationTitle("GetMeHome")
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
                        trips = try await viewModel.getTrips(from: viewModel.locationQueryMap[selectedDeparture] ?? "new_york", to: viewModel.locationQueryMap[selectedArrival] ?? "ithaca", on: newDateString, bus: viewModel.convertForQuery(value: selectedService), minTime: (showAdvancedOptions ? selectedTime : Date.init(timeIntervalSince1970: 0)))
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
            
            if showAdvancedOptions {
                DatePicker("Pick Earilest Bus Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .tint(.purple)
            }
            else {
                Button ("Show Advanced Options") {
                    showAdvancedOptions = true
                }
            }
        }
    }
}




