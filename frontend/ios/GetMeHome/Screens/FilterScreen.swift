//
//  FilterScreen.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 3/20/24.
//

import SwiftUI

struct FilterScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isLoading: Bool
    @Binding var earliestDepartureTimeLocal: Date?
    @Binding var depTimeFilter: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                }
                .tint(.blue)
            }
            .padding()
            
            Text("Filter Screen")
                .font(.title)
                .fontWeight(.bold)
            
            VStack{
                HStack{
                    Button {
                        depTimeFilter.toggle()
                    } label: {
                        Image(systemName: depTimeFilter ? "checkmark.circle.fill" : "circle")
                    }
                    Text("Earliest Departure Time")
                }
                DatePicker("Earliest Departure Time",
                           //                               Need complicated binding so I can make earliestDeparture nil
                           selection: Binding<Date>(get: {self.earliestDepartureTimeLocal ?? Date()}, set: {self.earliestDepartureTimeLocal = $0}),
                           displayedComponents: .hourAndMinute)
                .tint(.purple)
                .disabled(isLoading ? true : false)
                .opacity(isLoading ? 0.25 : 1.0)
            
            }
             
            
            Spacer()
        }
    }
}

