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
        }
    }
}
