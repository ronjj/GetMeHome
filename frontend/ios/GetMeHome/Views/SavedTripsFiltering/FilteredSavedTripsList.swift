//
//  FilteredSavedTripsList.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//

import SwiftUI

struct FilteredSavedTripsList: View {
    
    @FetchRequest(sortDescriptors: []) var savedTrips: FetchedResults<SavedTrip>

    @State private var savedTripsList = [SavedTrip]()
    @Environment (\.managedObjectContext) var managedObjectContext
    var viewModel = ViewModel()
    
    @Binding var sortingBy: String
    @Binding var isAscendingBinding: Bool
    @Binding var isSortingBinding: Bool
    @Binding var busServiceBinding: String
    
    @State private var showingDeleteAlert = false
    @State private var selectedSavedTripId: Int?
    
    var body: some View {
        VStack {
            Text("Saved Trips")
                .font(.title)
                .fontWeight(.black)
           
            
            SavedTripsFilterMenu(sortingBy: $sortingBy,
                                 isAscending: $isAscendingBinding,
                                 isSorting: $isSortingBinding,
                                 busService: $busServiceBinding)
            
           
            if savedTrips.isEmpty {
                ContentUnavailableView("No Saved Trips",
                                       systemImage: "bus.fill",
                                       description: Text("Saved Trips Will Appear Here"))
            } else {
                List {
                    ForEach(savedTrips) { savedTrip in
                        SavedTripRowView(savedTrip: savedTrip)
                        .onTapGesture {
                            showingDeleteAlert = true
                            selectedSavedTripId = Int(savedTrip.id)
                            AnalyticsManager.shared.logEvent(name: "SavedTripsView_SavedTripTapped")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteSavedTrip(offsets: indexSet)
                        AnalyticsManager.shared.logEvent(name: "SavedTripsView_SwipeToDelete")
                    })
                    
                }
            }
        }
        .alert("Delete Saved Trip?", isPresented: $showingDeleteAlert) {
            Button("Yes", role: .destructive) {
                if let selectedSavedTripId {
                    savedTrips.filter { $0.id == selectedSavedTripId }.forEach(managedObjectContext.delete)
                    DataContrller().save(context: managedObjectContext)
                    print("delete trip")
                    AnalyticsManager.shared.logEvent(name: "SavedTripsView_ClickConfirmDelete")
                }
            }
            Button("Cancel", role: .cancel) {
                AnalyticsManager.shared.logEvent(name: "SavedTripsView_CancelConfirmDelete")
            }
        }
    }
    
    init(sort: String, isAscending: Bool, isSorting: Bool, busService: String, sortingBy: Binding<String>, isAscendingBinding: Binding<Bool>, isSortingBinding: Binding<Bool>, busServiceBinding: Binding<String> ) {
        
        if isSorting {
            _savedTrips = FetchRequest<SavedTrip>(sortDescriptors: [.init(key: sort, ascending: isAscending)])
            
        } else {
            _savedTrips = FetchRequest<SavedTrip>(sortDescriptors: [],
                                                  predicate: NSPredicate(format: "busService == %@", busService))
        }
        
        self._sortingBy = sortingBy
        self._isAscendingBinding = isAscendingBinding
        self._isSortingBinding = isSortingBinding
        self._busServiceBinding = busServiceBinding
       
    }
    private func deleteSavedTrip(offsets: IndexSet) {
        withAnimation {
            offsets.map { savedTrips[$0] }.forEach(managedObjectContext.delete)
            DataContrller().save(context: managedObjectContext)
        }
    }
}

