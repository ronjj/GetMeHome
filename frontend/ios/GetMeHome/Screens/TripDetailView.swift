//
//  TripDetailView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI

struct TripDetailView: View {
    
    var trip: Trip
    var discountCodes: [Discount]
    var viewModel = ViewModel()
    
    @State private var date = Date()
    @State private var discountCodesFiltered = [Discount]()
    
    var body: some View {
        List {
            Section("Date") {
                Text(date, style: .date)
            }
            Section("Time") {
                Text("\(trip.departureTime) - \(trip.arrivalTime)")
            }
            Section("Price") {
                Text("$\(trip.price, specifier: "%.2f")")
            }
            Section("Departure") {
                Text("\(trip.departureLocation)")
            }
            Section("Destination") {
                Text("\(trip.arrivalLocation)")
            }
            
            Section("Intermediate Stops") {
                Text("\(trip.intermediateCount)")
            }
            
            Section("Bus Destinations") {
                VStack(alignment: .leading) {
                    ForEach(trip.intermediateStations, id: \.self) { station in
                        Text(station)
                    }
                }
            }
            
            if !discountCodes.isEmpty {
                Section("Discount Codes") {
                    VStack(alignment: .leading) {
                        ForEach(discountCodesFiltered) { discountCode in
                            Text("- \(discountCode.code)")
                        }
                    }
                }
            }
            
            Section("Bus Service") {
                Text("\(trip.busService)")
            }
        
            HStack {
                Spacer()
                Link("Buy on \(trip.busService) Website", destination: (URL(string: trip.ticketLink) ?? URL(string: viewModel.backupLinkMap[trip.busService]!))!)
                    .buttonStyle(.bordered)
                    .tint(.indigo)
                Spacer()
            }
        }
        .onAppear(perform: {
            let dateFormatter = DateFormatter()
            //               Get a Date type from trip.date string
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateDate = dateFormatter.date(from:trip.date)!
            //               Convert date to a Date object with a more readable format
            dateFormatter.dateFormat = "MMMM d, yyyy"
            let dateString = dateFormatter.string(from: dateDate)
            date = dateFormatter.date(from: dateString)!
            print(date)
            
            let filteredCodesForService = discountCodes.filter({$0.service == trip.busService})
            discountCodesFiltered = filteredCodesForService
        })
        .listStyle(.plain)
    }
}


