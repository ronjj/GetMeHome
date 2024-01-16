//
//  SavedTripsFilterMenu.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//

import SwiftUI


struct SavedTripsFilterMenu: View {
    
    @Binding var sortingBy: String
    @Binding var isAscending: Bool
    @Binding var isSorting: Bool
    @Binding var busService: String
    @State var selectedValue: String? = nil
    
    var body: some View {
        Menu(selectedValue != nil ? "Sort - \(selectedValue!)" : "Sort") {
            Button("Price Ascending") {
                sortingBy = "price"
                isAscending = true
                isSorting = true
                busService = "OurBus"
                selectedValue = "Price Ascending"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_PriceAscending")
            }
            Button("Price Descending") {
                sortingBy = "price"
                isAscending = false
                isSorting = true
                busService = "OurBus"
                selectedValue = "Price Descending"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_PriceDescending")
            }
            Button("Date Ascending") {
                sortingBy = "date"
                isAscending = true
                isSorting = true
                busService = "OurBus"
                selectedValue = "Date Ascending"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_DateAscend")
            }
            
            Button("Date Descending") {
                sortingBy = "date"
                isAscending = false
                isSorting = true
                busService = "OurBus"
                selectedValue = "Date Descending"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_DateDescend")
            }
            Button("OurBus Only") {
                sortingBy = "date"
                isAscending = false
                isSorting = false
                busService = "OurBus"
                selectedValue = "OurBus Only"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_OurBusOnly")
            }
            Button("FlixBus Only") {
                sortingBy = "date"
                isAscending = false
                isSorting = false
                busService = "FlixBus"
                selectedValue = "FlixBus Only"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_FlixBusOnly")
            }
            Button("MegaBus Only") {
                sortingBy = "date"
                isAscending = false
                isSorting = false
                busService = "MegaBus"
                selectedValue = "MegaBus Only"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_MegaBusOnly")
            }
        }
        .buttonStyle(.bordered)
        .tint(.purple)
    }
}
