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
    
    var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
           HStack {
                Text("Departure Location")
                Spacer()
                Menu(selectedDeparture) {
                    //                    Have to sort dict to iterate over it in SwiftUI. not actually necessary to sort
                    ForEach(viewModel.locationQueryMap.sorted(by: >), id: \.key)  { location, code in
                        if selectedDeparture != location && selectedArrival != location {
                            Button("\(location)") {
                                selectedDeparture = location
                                AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_DepLocClicked")
                                AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_\(location)Clicked")

                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .disabled(isLoading ? true : false)
                .tint(.purple)
            }
               
            HStack {
                Text("Arrival Location")
                Spacer()
                Menu(selectedArrival) {
                    ForEach(viewModel.locationQueryMap.sorted(by: >), id: \.key)  { location, code in
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
                .disabled(isLoading ? true : false)
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
        .analyticsScreen(name: "DateAndLocationPickerView")
    }
}
