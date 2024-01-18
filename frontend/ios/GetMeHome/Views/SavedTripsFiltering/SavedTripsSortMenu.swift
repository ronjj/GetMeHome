//
//  SavedTripsFilterMenu.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//

import SwiftUI

struct SavedTripsSortMenu: View {
    
    @Binding var sortingBy: String
    @Binding var isAscending: Bool
    @State var selectedValue: String? = nil
    
    var body: some View {
        Menu(selectedValue != nil ? "\(selectedValue!)" : "Sort") {
            Button("Price Ascending") {
                sortingBy = "price"
                isAscending = true
                selectedValue = "Price Ascending"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_PriceAscending")
            }
            Button("Price Descending") {
                sortingBy = "price"
                isAscending = false
                selectedValue = "Price Descending"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_PriceDescending")
            }
            Button("Date Ascending") {
                sortingBy = "date"
                isAscending = true
                selectedValue = "Date Ascending"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_DateAscend")
            }
            
            Button("Date Descending") {
                sortingBy = "date"
                isAscending = false
                selectedValue = "Date Descending"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_DateDescend")
            }
          
        }
        .buttonStyle(.bordered)
        .tint(.purple)
    }
}

struct SavedTripsFilterMenu: View {
    @Binding var busService: String
    @Binding var isFiltering: Bool
    @State var selectedBusService: String? = nil
    var body: some View {
        Menu(selectedBusService != nil ? "\(selectedBusService!)" : "Filter") {
            Button("All") {
//                I kept this as OurBus just in case the value gets passed into the NSPredicate
//                There is no all service so keeping it as OurBus prevents a fatal crash
                busService = "OurBus"
                isFiltering = false
                selectedBusService = "All"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_All")
            }
            Button("OurBus Only") {
                busService = "OurBus"
                isFiltering = true
                selectedBusService = "OurBus Only"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_OurBusOnly")
            }
            Button("FlixBus Only") {
                busService = "FlixBus"
                isFiltering = true
                selectedBusService = "FlixBus Only"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_FlixBusOnly")
            }
            Button("MegaBus Only") {
                busService = "MegaBus"
                isFiltering = true
                selectedBusService = "MegaBus Only"
                AnalyticsManager.shared.logEvent(name: "SavedTripsFiltering_MegaBusOnly")
            }
        }
        .buttonStyle(.bordered)
        .tint(.purple)
    }
}
