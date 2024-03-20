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
    @Binding var latestArrivalTimeLocal: Date?
    @Binding var latestArrivalTimeToggle: Bool
    @Binding var depTimeFilter: Bool
    @Binding var maxPriceToggle: Bool
    @Binding var maxPriceLocal: Double
    @Binding var selectedServiceLocal: String
    @Binding var selectServiceToggle: Bool
    @Binding var removeTransfersToggle: Bool
    
    var viewModel = ViewModel()
    
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
            
            Text("Filters")
                .font(.title)
                .bold()
            
//            Earliest Dep Time
            HStack{
                Button {
                    depTimeFilter.toggle()
                } label: {
                    Image(systemName: depTimeFilter ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                }
                .tint(.purple)
                Text("Earliest Departure Time")
                
                    DatePicker("Earliest Departure Time",
                               //                               Need complicated binding so I can make earliestDeparture nil
                               selection: Binding<Date>(get: {self.earliestDepartureTimeLocal ?? Date()}, set: {self.earliestDepartureTimeLocal = $0}),
                               displayedComponents: .hourAndMinute)
                    .tint(.purple)
                    .disabled(isLoading ? true : false)
                    .disabled(!depTimeFilter ? true : false)
                    .opacity(isLoading ? 0.25 : 1.0)
                    .opacity(!depTimeFilter ? 0.25 : 1.0)
                    .labelsHidden()
                    
            }
            
            
//            Max Price
            HStack{
                Button {
                    maxPriceToggle.toggle()
                } label: {
                    Image(systemName: maxPriceToggle ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                }
                .tint(.purple)
                
                Text("Max Price")
               
                HStack {
                    Slider(value: $maxPriceLocal, in: 1...300, step: 1.0)
                    Text("$\(maxPriceLocal, specifier: "%.2f")")
                }
                .tint(.purple)
                .disabled(isLoading ? true : false)
                .disabled(!maxPriceToggle ? true : false)
                .opacity(isLoading ? 0.25 : 1.0)
                .opacity(!maxPriceToggle ? 0.25 : 1.0)
                .labelsHidden()
            }
            .padding(.horizontal)
            
//            Select Bus
            HStack{
                Button {
                    selectServiceToggle.toggle()
                } label: {
                    Image(systemName: selectServiceToggle ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                }
                .tint(.purple)
                
                VStack (alignment: .leading){
                    Text("Choose A Bus Service")
                    Picker("Choose A Bus Service", selection: $selectedServiceLocal) {
                        ForEach(viewModel.services, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.palette)
                    .disabled(isLoading ? true : false)
                    .disabled(!selectServiceToggle ? true : false)
                    .opacity(isLoading ? 0.25 : 1.0)
                    .opacity(!selectServiceToggle ? 0.4 : 1.0)
                }
            }
                
//                Remove Transfers
            HStack{
                Text("Remove Transfers")
                
                Button {
                    removeTransfersToggle.toggle()
                } label: {
                    Image(systemName: removeTransfersToggle ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                }
                .tint(.purple)
                .disabled(isLoading ? true : false)
                .opacity(isLoading ? 0.25 : 1.0)
                
            }
                
//                Latest Arrival
                
                HStack{
                    Button {
                        latestArrivalTimeToggle.toggle()
                    } label: {
                        Image(systemName: latestArrivalTimeToggle ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                    }
                    .tint(.purple)
                    DatePicker("Latest Arrival Time",
                               selection: Binding<Date>(get: {self.latestArrivalTimeLocal ?? Date()}, set: {self.latestArrivalTimeLocal = $0}),
                               displayedComponents: .hourAndMinute)
                    .tint(.purple)
                    .disabled(isLoading ? true : false)
                    .disabled(!latestArrivalTimeToggle ? true : false)
                    .opacity(isLoading ? 0.25 : 1.0)
                    .opacity(!latestArrivalTimeToggle ? 0.25 : 1.0)
                }
            }
            
            .padding(.horizontal)
        
            Spacer()
        }
    }


