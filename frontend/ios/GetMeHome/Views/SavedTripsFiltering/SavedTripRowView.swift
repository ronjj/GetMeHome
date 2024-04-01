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
        if savedTrip.date != nil {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(viewModel.convertToDate(dateString:savedTrip.date ?? ""), style: .date)
                        .strikethrough(expired ? true  : false)
                        .font(.title2)
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
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("$\(savedTrip.price, specifier: "%.2f")")
                        .fontWeight(.bold)
                        .font(.headline)
                        .strikethrough(expired ? true  : false)
                    HStack (spacing: 2) {
                        Image(systemName: "clock")
                        Text(savedTrip.departureTime ?? "")
                            .strikethrough(expired ? true  : false)
                        Image(systemName: "arrow.right")
                        Text(savedTrip.arrivalTime ?? "")
                            .strikethrough(expired ? true  : false)
                    }
                    if !expired {
                        VStack(alignment: .leading) {
                            
                            Text("Departure Location")
                                .bold()
                            Text(savedTrip.departureLocation ?? "")
                        }
                        
                        VStack(alignment: .leading) {
                            
                            Text("Arrival Location")
                                .bold()
                            Text(savedTrip.arrivalLocation ?? "")
                        }
                        
                        if savedTrip.nonStop == "False" {
                            HStack {
                                BusLabel(busService: "indirect")
                            }
                        }
                        
                        HStack {
                            if !expired {
                                Link("Buy on \(savedTrip.busService!)",
                                     destination: (URL(string: savedTrip.ticketLink ?? "") ?? URL(string: viewModel.backupLinkMap[savedTrip.busService ?? ""]!))!)
                                .buttonStyle(.borderedProminent)
                                .tint(.indigo)
                                .onTapGesture {
                                    AnalyticsManager.shared.logEvent(name: "SavedTripsView_BuyTicketClicked")
                                }
                            }
                            
                            Spacer()
                            
                            BusLabel(busService: savedTrip.busService ?? "")
                        }
                    }
                }
                .disabled(expired ? true : false)
            }
        }
    }
}

