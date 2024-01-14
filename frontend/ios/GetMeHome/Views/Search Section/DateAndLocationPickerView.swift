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

                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
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
                                AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_ArrLocClicked")
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .tint(.purple)
            }
            
            HStack {
                Text("Travel Date")
                Spacer()
                DatePicker("Trip Date", selection: $selectedDate, in:Date.now...viewModel.calculateDateRange(), displayedComponents: .date)
                    
                    .labelsHidden()
                    .tint(.purple)
            }
        }
        .analyticsScreen(name: "DateAndLocationPickerView")
    }
}
