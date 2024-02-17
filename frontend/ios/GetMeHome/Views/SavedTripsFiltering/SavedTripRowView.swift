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
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button {
                        savedTripId = Int(Int16(savedTrip.id))
                        showDeleteAlert = true
                    } label: {
                        Image(systemName: "x.circle")
                    }
                    .tint(.red)
                    .buttonStyle(.bordered)
                }
               
                if let savedTripDate = savedTrip.date {
                    VStack(alignment: .leading) {
                        Text("$\(savedTrip.price, specifier: "%.2f")")
                            .fontWeight(.bold)
                        HStack {
                            Image(systemName: "calendar")
                            Text("EXPIRED")
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                            Text(viewModel.convertToDate(dateString:savedTrip.date ?? ""), style: .date)
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
                    }
                    .disabled(true)
                }
            }
            
        } else {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button {
                        savedTripId = Int(Int16(savedTrip.id))
                        showDeleteAlert = true
                    } label: {
                        Image(systemName: "x.circle")
                    }
                    .tint(.red)
                    .buttonStyle(.bordered)
                }
                if let savedTripDate = savedTrip.date {
                    VStack(alignment: .leading) {
                        Text("$\(savedTrip.price, specifier: "%.2f")")
                            .fontWeight(.bold)
                        HStack {
                            Image(systemName: "calendar")
                            Text(viewModel.convertToDate(dateString:savedTrip.date ?? ""), style: .date)
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
                }
            }
        }
    }
}
