//
//  BoughtTicketsView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/8/24.
//

import SwiftUI

struct BoughtTicketsView: View {
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
        
        .analyticsScreen(name: "BoughtTicketsView")
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "BoughtTicketsView_Appear")
        }
    }
}

