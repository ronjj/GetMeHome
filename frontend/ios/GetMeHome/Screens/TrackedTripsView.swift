//
//  TrackedTripsView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/25/24.
//

import SwiftUI

struct TrackedTripsView: View {
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Tracked Trips")
                    .font(.title)
                    .fontWeight(.black)
            }
            List {
                Text("hello world")
//                ForEach(TrackedTripsView.trackedTrips, id: \.self) { trackedTrip in
//                    SavedTripRowDesign(expired: <#T##Bool#>, savedTrip: <#T##SavedTrip#>, savedTripId: <#T##Binding<Int?>#>, showDeleteAlert: <#T##Binding<Bool>#>)
//                }
            }
        }
    }
}


struct TrackedTrip: Hashable {
    var email: String
    var arrivalLocation: String
    var departureLocation: String
    var date: String
    var price: Float
    var nonStop: String
    var busService: String
    var ticketLink: String
}


struct TrackedTripsRowDesign: View {
    
    var expired: Bool
    var trackedTrip: TrackedTrip
    @Binding var showDeleteAlert: Bool
    var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button {
                    showDeleteAlert = true
                    AnalyticsManager.shared.logEvent(name: "TrackedTripsRowView_XButtonClicked")
                } label: {
                    Image(systemName: "x.circle")
                }
                .tint(.red)
                .buttonStyle(.bordered)
            }
            VStack(alignment: .leading) {
                Text("$\(trackedTrip.price, specifier: "%.2f")")
                    .fontWeight(.bold)
                    .strikethrough(expired ? true  : false)
                HStack {
                    Image(systemName: "calendar")
                    if expired {
                        Text("EXPIRED")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                    }
                    Text(viewModel.convertToDate(dateString:trackedTrip.date ), style: .date)
                        .strikethrough(expired ? true  : false)
                }
                if !expired {
                    HStack {
                        Image(systemName: "bus.fill")
                        Text(trackedTrip.departureLocation )
                    }
                    HStack {
                        Image(systemName: "star.fill")
                        Text(trackedTrip.arrivalLocation )
                    }
                }
                if trackedTrip.nonStop == "False" {
                    HStack {
                        BusLabel(busService: trackedTrip.busService )
                        BusLabel(busService: "indirect")
                    }
                }
                else {
                    BusLabel(busService: trackedTrip.busService )
                }
                if !expired {
                    Link("Buy on \(trackedTrip.busService) Website",
                         destination: (URL(string: trackedTrip.ticketLink ) ?? URL(string: viewModel.backupLinkMap[trackedTrip.busService ]!))!)
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                    .onTapGesture {
                        AnalyticsManager.shared.logEvent(name: "SavedTripsView_BuyTicketClicked")
                    }
                }
            }
            .disabled(expired ? true : false)
            
        }
    }
}

struct TrackedTripRowView: View {
    
    @State var showDeleteAlert: Bool = false
    var trackedTrip: TrackedTrip
    var viewModel = ViewModel()
    
    var body: some View {
        //        TODO: make sure i'm using correct format with trackedTrip date
        if trackedTrip.date < viewModel.convertDateToString(date: Date()) {
            TrackedTripsRowDesign(expired: true,
                                  trackedTrip: trackedTrip,
                                  showDeleteAlert: $showDeleteAlert)
        } else {
            TrackedTripsRowDesign(expired: false,
                                  trackedTrip: trackedTrip,
                                  showDeleteAlert: $showDeleteAlert)
        }
    }
}
