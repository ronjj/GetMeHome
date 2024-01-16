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
    @Binding var includeTransfersSelected: Bool
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button {
                    minDepartureTimeSelected.toggle()
                    AnalyticsManager.shared.logEvent(name: "FilterRowView_MinDepClicked")
                } label: {
                    FilterButton(buttonTitle: "Departure Time", isSelected: $minDepartureTimeSelected)
                }
                Button {
                    latestArrivalTimeSelected.toggle()
                    AnalyticsManager.shared.logEvent(name: "FilterRowView_LatestArrClicked")
                } label: {
                    FilterButton(buttonTitle: "Arrival Time", isSelected: $latestArrivalTimeSelected)
                }
                Button {
                    chooseBusServiceSelected.toggle()
                    AnalyticsManager.shared.logEvent(name: "FilterRowView_ChooseBusClicked")
                } label: {
                    FilterButton(buttonTitle: "Bus Service", isSelected: $chooseBusServiceSelected)
                }
                Button {
                    includeTransfersSelected.toggle()
                    AnalyticsManager.shared.logEvent(name: "FilterRowView_RemoveTransfersClicked")
                } label: {
                    FilterButton(buttonTitle: "Remove Transfers", isSelected: $includeTransfersSelected)
                }
            }
        }
        .scrollIndicators(.hidden)
        .analyticsScreen(name: "FilterRowView")
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
