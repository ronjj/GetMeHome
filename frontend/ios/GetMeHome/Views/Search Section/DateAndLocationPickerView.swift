//
//  DateAndLocationPickerView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/8/24.
//

import SwiftUI

struct DateAndLocationPickerView: View {
    
    @Binding var selectedDeparture: String
    @Binding var selectedArrival: String
    @Binding var selectedDate: Date
    @Binding var isLoading: Bool
    @State var newYorkLocations = [String]()
    @State var otherLocations = [String]()
    
    var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
           HStack {
                Text("Departure Location")
                Spacer()
                Menu(selectedDeparture) {
                    Section("New York Stops") {
                        ForEach(newYorkLocations, id: \.self) { location in
                            if selectedArrival != location && selectedDeparture != location {
                                Button("\(location)") {
                                    selectedDeparture = location
                                    AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_\(location)Clicked")
                                    AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_ArrLocClicked")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                    Section("Other Stops") {
                        ForEach(otherLocations, id: \.self) { location in
                            if selectedArrival != location && selectedDeparture != location {
                                Button("\(location)") {
                                    selectedDeparture = location
                                    AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_\(location)Clicked")
                                    AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_ArrLocClicked")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                }
                .disabled(isLoading ? true : false)
                .buttonStyle(.bordered)
                .tint(.purple)
            }
               
            HStack {
                Text("Arrival Location")
                Spacer()
                Menu(selectedArrival) {
                    Section("New York Stops") {
                        ForEach(newYorkLocations, id: \.self) { location in
                            if selectedArrival != location && selectedDeparture != location {
                                Button("\(location)") {
                                    selectedArrival = location
                                    AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_\(location)Clicked")
                                    AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_ArrLocClicked")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                    Section("Other Stops") {
                        ForEach(otherLocations, id: \.self) { location in
                            if selectedArrival != location && selectedDeparture != location {
                                Button("\(location)") {
                                    selectedArrival = location
                                    AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_\(location)Clicked")
                                    AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_ArrLocClicked")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                }
                .disabled(isLoading ? true : false)
                .buttonStyle(.bordered)
                .tint(.purple)
            }
            
            HStack {
                Text("Travel Date")
                Spacer()
                DatePicker("Trip Date", selection: $selectedDate, in:Date.now...viewModel.calculateDateRange(), displayedComponents: .date)
                    .labelsHidden()
                    .tint(.purple)
                    .disabled(isLoading ? true : false)
                    .opacity(isLoading ? 0.35 : 1.0)
            }
            .onChange(of: selectedDate) { oldValue, newValue in
                AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_DateClicked")
                AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_\(selectedDate)")
            }
        }
        .onAppear {
            viewModel.locationQueryMap.forEach({ location, code in
                if location.contains("NY") || location.contains("SYR") {
                    newYorkLocations.append(location)
                } else {
                    otherLocations.append(location)
                }
            })
        }
        .analyticsScreen(name: "DateAndLocationPickerView")
    }
}
