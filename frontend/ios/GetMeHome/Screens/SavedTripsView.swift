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
    @State var isSorting: Bool = true
    @State var busService = "OurBus"
    @State var isFiltering: Bool = false
    
    var body: some View {
            FilteredSavedTripsList(sort: sortingBy,
                                   isAscending: isAscending,
                                   busService: busService, 
                                   isFiltering: $isFiltering,
                                   sortingBy: $sortingBy,
                                   isAscendingBinding: $isAscending,
                                   busServiceBinding: $busService)
        
        .analyticsScreen(name: "SavedTripsView")
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "SavedTripsView_Appear")
        }
    }
}

