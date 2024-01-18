//
//  SavedTripRowView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/16/24.
//

import SwiftUI

struct SavedTripRowView: View {
    var savedTrip: SavedTrip
    var viewModel = ViewModel()
    @Binding var savedTripId: Int?
    @Binding var showDeleteAlert: Bool
    
    var body: some View {
        if savedTrip.date ?? "" < viewModel.convertDateToString(date: Date()) {
          SavedTripRowDesign(expired: true,
                             savedTrip: savedTrip,
                             savedTripId: $savedTripId,
                             showDeleteAlert: $showDeleteAlert)
        } else {
            SavedTripRowDesign(expired: false,
                               savedTrip: savedTrip,
                               savedTripId: $savedTripId,
                               showDeleteAlert: $showDeleteAlert)
        }
    }
}


struct SavedTripRowDesign: View {
    var expired: Bool
    var savedTrip: SavedTrip
    var viewModel = ViewModel()
    @Binding var savedTripId: Int?
    @Binding var showDeleteAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button {
                    savedTripId = Int(Int16(savedTrip.id))
                    showDeleteAlert = true
                    AnalyticsManager.shared.logEvent(name: "SavedTripRowView_XButtonClicked")
                } label: {
                    Image(systemName: "x.circle")
                }
                .tint(.red)
                .buttonStyle(.bordered)
            }
            if savedTrip.date != nil {
                VStack(alignment: .leading) {
                    Text("$\(savedTrip.price, specifier: "%.2f")")
                        .fontWeight(.bold)
                        .strikethrough(expired ? true  : false)
                    HStack {
                        Image(systemName: "calendar")
                        if expired {
                            Text("EXPIRED")
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                        Text(viewModel.convertToDate(dateString:savedTrip.date ?? ""), style: .date)
                            .strikethrough(expired ? true  : false)
                    }
                    HStack (spacing: 2) {
                        Image(systemName: "clock")
                        Text(savedTrip.departureTime ?? "")
                            .strikethrough(expired ? true  : false)
                        Image(systemName: "arrow.right")
                        Text(savedTrip.arrivalTime ?? "")
                            .strikethrough(expired ? true  : false)
                    }
                    if !expired {
                        HStack {
                            Image(systemName: "bus.fill")
                            Text(savedTrip.departureLocation ?? "")
                        }
                        HStack {
                            Image(systemName: "star.fill")
                            Text(savedTrip.arrivalLocation ?? "" )
                        }
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
                    if !expired {
                        Link("Buy on \(savedTrip.busService!) Website",
                             destination: (URL(string: savedTrip.ticketLink ?? "") ?? URL(string: viewModel.backupLinkMap[savedTrip.busService ?? ""]!))!)
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
}

