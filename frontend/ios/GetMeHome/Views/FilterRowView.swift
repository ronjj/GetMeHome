//
//  FilterRowView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/8/24.
//

import SwiftUI

struct FilterRowView: View {
    
    @Binding var minDepartureTimeSelected: Bool
    @Binding var latestArrivalTimeSelected: Bool
    @Binding var chooseBusServiceSelected: Bool
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button {
                    minDepartureTimeSelected.toggle()
                } label: {
                    FilterButton(buttonTitle: "Departure Time", isSelected: $minDepartureTimeSelected)
                }
                Button {
                    latestArrivalTimeSelected.toggle()
                } label: {
                    FilterButton(buttonTitle: "Arrival Time", isSelected: $latestArrivalTimeSelected)
                }
                Button {
                    chooseBusServiceSelected.toggle()
                } label: {
                    FilterButton(buttonTitle: "Bus Service", isSelected: $chooseBusServiceSelected)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct FilterButton: View {
    
    var buttonTitle: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(buttonTitle)
            .frame(height: 30)
            .padding(.horizontal)
            .foregroundColor(isSelected ? .white : .black)
            .background(isSelected ? .purple : .gray.opacity(0.5))
            .cornerRadius(10)
    }
}
