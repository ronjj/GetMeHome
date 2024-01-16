//
//  SavedTripsView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//

import SwiftUI

struct SavedTripsView: View {
    var viewModel = ViewModel()
    @State var sortingBy: String = "price"
    @State var isAscending: Bool = true
    
    var body: some View {
        NavigationStack {
            SavedTripsFilterRowView(sortingBy: $sortingBy, isAscending: $isAscending)
            FilteredSavedTripsList(sort: sortingBy, isAscending: isAscending)
        }
        .analyticsScreen(name: "SavedTripsView")
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "SavedTripsView_Appear")
        }
    }
}

struct SavedTripsFilterRowView: View {
    
    @Binding var sortingBy: String
    @Binding var isAscending: Bool
    
    var body: some View {
        Menu("Sort") {
            Button("Price Ascending") {
                sortingBy = "price"
                isAscending = true
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_PriceAscending")
            }
            Button("Price Descending") {
                sortingBy = "price"
                isAscending = false
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_PriceDescending")
            }
            Button("Date Ascending") {
                sortingBy = "date"
                isAscending = true
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_DateAscend")
            }
            
            Button("Date Descending") {
                sortingBy = "date"
                isAscending = false
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_DateDescend")
            }
        }
    }
}
