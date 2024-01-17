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
    @Binding var isLoading: Bool
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button {
                    minDepartureTimeSelected.toggle()
                    AnalyticsManager.shared.logEvent(name: "FilterRowView_MinDepClicked")
                } label: {
                    FilterButton(buttonTitle: "Departure Time", isSelected: $minDepartureTimeSelected, isDisabled: $isLoading)
                }
                .disabled(isLoading ? true : false)
                Button {
                    latestArrivalTimeSelected.toggle()
                    AnalyticsManager.shared.logEvent(name: "FilterRowView_LatestArrClicked")
                } label: {
                    FilterButton(buttonTitle: "Arrival Time", isSelected: $latestArrivalTimeSelected, isDisabled: $isLoading)
                }
                .disabled(isLoading ? true : false)
                Button {
                    chooseBusServiceSelected.toggle()
                    AnalyticsManager.shared.logEvent(name: "FilterRowView_ChooseBusClicked")
                } label: {
                    FilterButton(buttonTitle: "Bus Service", isSelected: $chooseBusServiceSelected, isDisabled: $isLoading)
                }
                .disabled(isLoading ? true : false)
                Button {
                    includeTransfersSelected.toggle()
                    AnalyticsManager.shared.logEvent(name: "FilterRowView_RemoveTransfersClicked")
                } label: {
                    FilterButton(buttonTitle: "Remove Transfers", isSelected: $includeTransfersSelected, isDisabled: $isLoading)
                }
            }
        }
        .disabled(isLoading ? true : false)
        .scrollIndicators(.hidden)
        .analyticsScreen(name: "FilterRowView")
    }
}

struct FilterButton: View {
    var buttonTitle: String
    @Binding var isSelected: Bool
    @Binding var isDisabled: Bool
    
    var body: some View {
        Text(buttonTitle)
            .frame(height: 30)
            .padding(.horizontal)
            .foregroundColor(isSelected ? .white : .black)
            .background(isSelected ? .purple : .gray.opacity(0.5))
            .cornerRadius(10)
            .opacity(isDisabled ? 0.25 : 1.0)
    }
}
