//
//  SavedTripsView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//

import SwiftUI

struct SavedTripsView: View {
    
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var savedTrips: FetchedResults<SavedTrip>
    
    var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Saved Trips")
                    .font(.title)
                    .fontWeight(.black)
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
                                .buttonStyle(.bordered)
                                .tint(.indigo)
                                .onTapGesture {
                                    AnalyticsManager.shared.logEvent(name: "SavedTripsView_BuyTicketClicked")
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteSavedTrip(offsets: indexSet)
        //                analyticsTracking here
                    })
                }
            }
          
        }
        .analyticsScreen(name: "SavedTripsView")
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "SavedTripsView_Appear")
        }
    }
    private func deleteSavedTrip(offsets: IndexSet) {
        withAnimation {
            offsets.map { savedTrips[$0] }.forEach(managedObjectContext.delete)
            DataContrller().save(context: managedObjectContext)
        }
    }
}

#Preview {
    SavedTripsView()
}
