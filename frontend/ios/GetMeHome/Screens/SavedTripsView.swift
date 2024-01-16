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
    
    var body: some View {
            FilteredSavedTripsList(sort: sortingBy,
                                   isAscending: isAscending,
                                   isSorting: isSorting,
                                   busService: busService,
                                   sortingBy: $sortingBy,
                                   isAscendingBinding: $isAscending,
                                   isSortingBinding: $isSorting,
                                   busServiceBinding: $busService)
            
        
//            SavedTripsFilterMenu(sortingBy: $sortingBy,
//                                 isAscending: $isAscending,
//                                 isSorting: $isSorting,
//                                 busService: $busService)
                
            
        
        .analyticsScreen(name: "SavedTripsView")
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "SavedTripsView_Appear")
        }
    }
}

