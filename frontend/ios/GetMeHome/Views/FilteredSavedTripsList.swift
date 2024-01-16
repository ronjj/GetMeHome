//
//  FilteredSavedTripsList.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//

import SwiftUI

struct FilteredSavedTripsList: View {
    
    @FetchRequest(sortDescriptors: []) var savedTrips: FetchedResults<SavedTrip>
    @State private var showingDeleteAlert = false
    @State private var selectedSavedTripId: Int?
    @State private var savedTripsList = [SavedTrip]()
    @Environment (\.managedObjectContext) var managedObjectContext
    var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Saved Trips")
                .font(.title)
                .fontWeight(.black)
            if savedTrips.isEmpty {
                ContentUnavailableView("No Saved Trips",
                                       systemImage: "bus.fill",
                                       description: Text("Saved Trips Will Appear Here"))
            } else {
                List {
                    ForEach(savedTrips) { savedTrip in
                        VStack(alignment: .leading) {
                            Text("$\(savedTrip.price, specifier: "%.2f")")
                                .fontWeight(.bold)
                            HStack {
                                Image(systemName: "calendar")
                                Text(savedTrip.date ?? "")
                            }
                            HStack (spacing: 2) {
                                Image(systemName: "clock")
                                Text(savedTrip.departureTime ?? "")
                                Image(systemName: "arrow.right")
                                Text(savedTrip.arrivalTime ?? "")
                            }
                            HStack {
                                Image(systemName: "bus.fill")
                                Text(savedTrip.departureLocation ?? "")
                            }
                            HStack {
                                Image(systemName: "star.fill")
                                Text(savedTrip.arrivalLocation ?? "" )
                            }
                            if savedTrip.nonStop == "False" {
                                HStack {
                                    BusLabel(busService: savedTrip.busService ?? "")
                                    BusLabel(busService: "indirect")
                                }
                            }
                            else {
                                BusLabel(busService: savedTrip.busService ?? "")
                            }
                            Link("Buy on \(savedTrip.busService!) Website",
                                 destination: (URL(string: savedTrip.ticketLink ?? "") ?? URL(string: viewModel.backupLinkMap[savedTrip.busService ?? ""]!))!)
                            .buttonStyle(.borderedProminent)
                            .tint(.indigo)
                            .onTapGesture {
                                AnalyticsManager.shared.logEvent(name: "SavedTripsView_BuyTicketClicked")
                            }
                        }
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
                    AnalyticsManager.shared.logEvent(name: "SavedTripsView_ClickConfirmDelete")
                }
            }
            Button("Cancel", role: .cancel) {
                AnalyticsManager.shared.logEvent(name: "SavedTripsView_CancelConfirmDelete")
            }
        }
    }
    init(sort: String, isAscending: Bool) {
        _savedTrips = FetchRequest<SavedTrip>(sortDescriptors: [.init(key: sort, ascending: isAscending)])
    }
    private func deleteSavedTrip(offsets: IndexSet) {
        withAnimation {
            offsets.map { savedTrips[$0] }.forEach(managedObjectContext.delete)
            DataContrller().save(context: managedObjectContext)
        }
    }
}
