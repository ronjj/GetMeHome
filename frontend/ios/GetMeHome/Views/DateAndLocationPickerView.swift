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
    @Binding var switchOriginAndDestinationButtonClicked: Bool
    @Binding var selectedDate: Date
    
    
    var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack{
                DatePicker("Trip Date", selection: $selectedDate, in:Date.now...viewModel.calculateDateRange(), displayedComponents: .date)
                    .labelsHidden()
                    .tint(.purple)
                Menu(selectedDeparture) {
//                    Have to sort dict to iterate over it in SwiftUI. not actually necessary to sort
                    ForEach(viewModel.locationQueryMap.sorted(by: >), id: \.key)  { location, code in
                        if selectedDeparture != location && selectedArrival != location {
                            Button("\(location)") {
                                selectedDeparture = location
                            }
                        }
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
                    Image(systemName: "arrow.right")
                        .scaleEffect(0.8)
                }
                .buttonStyle(.bordered)
                .tint(.purple)
                
                
                Menu(selectedArrival) {
                    ForEach(viewModel.locationQueryMap.sorted(by: >), id: \.key)  { location, code in
                        if selectedArrival != location && selectedDeparture != location {
                            Button("\(location)") {
                                selectedArrival = location
                            }
                        }
                    }
                }
                .padding(.horizontal, 0)
                .tint(.purple)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}
