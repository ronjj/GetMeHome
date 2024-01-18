//
//  FilteredSavedTripsList.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//

import SwiftUI

struct FilteredSavedTripsList: View {
    
    @FetchRequest(sortDescriptors: []) var savedTrips: FetchedResults<SavedTrip>

    @Environment (\.managedObjectContext) var managedObjectContext
    var viewModel = ViewModel()
    
    @Binding var sortingBy: String
    @Binding var isAscendingBinding: Bool
    @Binding var busServiceBinding: String
    @Binding private var isFiltering: Bool
    
    @State private var showingDeleteAlert = false
    @State private var selectedSavedTripId: Int?
    @State private var showingRemovedExpiredAlert = false
    @State private var showingRemovedExpiredButton = false

    
    var body: some View {
        VStack {
            Text("Saved Trips")
                .font(.title)
                .fontWeight(.black)
           
            HStack {
                SavedTripsSortMenu(sortingBy: $sortingBy,
                                   isAscending: $isAscendingBinding)
                
                SavedTripsFilterMenu(busService: $busServiceBinding, 
                                     isFiltering: $isFiltering)
            }
            .padding(.horizontal)
            
            if showingRemovedExpiredButton {
                Button {
                    AnalyticsManager.shared.logEvent(name: "FilteredSavedTripsList_RemoveExpiredClicked")
                    savedTrips.filter { $0.date ?? "" < viewModel.convertDateToString(date: Date()) }.forEach(managedObjectContext.delete)
                    DataContrller().save(context: managedObjectContext)
                    showingRemovedExpiredAlert = true
                    print("removed all expired trips")
                } label: {
                    Text("Remove Expired")
                }
                .buttonStyle(.bordered)
                .tint(.purple)
            }
          
            if savedTrips.isEmpty {
                ContentUnavailableView("No Saved Trips",
                                       systemImage: "bus.fill",
                                       description: Text("Save Trips Or Adjust Filter Settings"))
            } else {
                List {
                    ForEach(savedTrips) { savedTrip in
                        SavedTripRowView(savedTrip: savedTrip,
                                         savedTripId: $selectedSavedTripId,
                                         showDeleteAlert: $showingDeleteAlert)
                        .onTapGesture {
                            showingDeleteAlert = true
                            selectedSavedTripId = Int(savedTrip.id)
                            AnalyticsManager.shared.logEvent(name: "SavedTripsView_SavedTripTapped")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        withAnimation(.easeIn(duration: 1.75)) {
                            deleteSavedTrip(offsets: indexSet)
                        }
                        AnalyticsManager.shared.logEvent(name: "SavedTripsView_SwipeToDelete")
                    })
                }
            }
        }
        .onAppear {
            if savedTrips.filter({ $0.date ?? "" < viewModel.convertDateToString(date: Date())}).isEmpty {
                showingRemovedExpiredButton = false
            } else {
                showingRemovedExpiredButton = true
            }
        }
        .alert("Removed Expired Trips", isPresented: $showingRemovedExpiredAlert) {
            Button("Ok", role: .cancel) {}
        }
        .alert("Delete Saved Trip?", isPresented: $showingDeleteAlert) {
            Button("Yes", role: .destructive) {
                if let selectedSavedTripId {
                    withAnimation(.snappy(duration: 1.0)) {
                        savedTrips.filter { $0.id == selectedSavedTripId }.forEach(managedObjectContext.delete)
                        DataContrller().save(context: managedObjectContext)
                    }
                    AnalyticsManager.shared.logEvent(name: "SavedTripsView_ClickConfirmDelete")
                }
            }
            Button("Cancel", role: .cancel) {
                AnalyticsManager.shared.logEvent(name: "SavedTripsView_CancelConfirmDelete")
            }
        }
    }
    
    init(sort: String, isAscending: Bool, busService: String, isFiltering: Binding<Bool>, sortingBy: Binding<String>, isAscendingBinding: Binding<Bool>,  busServiceBinding: Binding<String> ) {
        
        if isFiltering.wrappedValue {
            _savedTrips = FetchRequest<SavedTrip>(sortDescriptors: [.init(key: sort, ascending: isAscending)],
                                                  predicate: NSPredicate(format: "busService == %@", busService))
            
        } else {
            _savedTrips = FetchRequest<SavedTrip>(sortDescriptors: [.init(key: sort, ascending: isAscending)])
        }
        
        self._sortingBy = sortingBy
        self._isAscendingBinding = isAscendingBinding
        self._busServiceBinding = busServiceBinding
        self._isFiltering = isFiltering
        
       
    }
    private func deleteSavedTrip(offsets: IndexSet) {
        withAnimation {
            offsets.map { savedTrips[$0] }.forEach(managedObjectContext.delete)
            DataContrller().save(context: managedObjectContext)
        }
    }
}

