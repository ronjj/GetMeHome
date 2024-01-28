//
//  TrackedTripsView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/25/24.
//

import SwiftUI

struct TrackedTripsView: View {
    
    @State var presentAddTrackedTripSheet = false
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Tracked Trips")
                    .font(.title)
                    .fontWeight(.black)
            }
            List {
                Section("Tracking") {
//                ForEach(TrackedTripsView.trackedTrips, id: \.self) { trackedTrip in
//                    SavedTripRowDesign(expired: <#T##Bool#>, savedTrip: <#T##SavedTrip#>, savedTripId: <#T##Binding<Int?>#>, showDeleteAlert: <#T##Binding<Bool>#>)
//                }
                }
            }
        }
        .sheet(isPresented: $presentAddTrackedTripSheet) {
                print("Sheet dismissed!")
            } content: {
                AddTrackedTripForm()
            }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    presentAddTrackedTripSheet.toggle()
                } label: {
                    Image(systemName:"plus")
                }
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

struct AddTrackedTripForm: View {
    
    @State var departureLocation: String = "Ithaca, NY"
    @State var arrivalLocation: String = "NYC"
    @State var date: Date = Date()
    @State var price: Float = 0.0
    @State var isLoading = false
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("Add Tracked Trip")
                    .font(.title)
                    .fontWeight(.bold)
            }
            DateAndLocationPickerView(selectedDeparture: $departureLocation,
                                      selectedArrival: $arrivalLocation,
                                      selectedDate: $date,
                                      isLoading: $isLoading)
            HStack {
                Text("Max Price")
                Spacer()
                Slider(value: $price, in: 1...400, step: 1.0)
                Text("$\(price, specifier: "%.2f")")
            }
            
            Button {
//                  save to firebase
            } label: {
                Text("Save")
            }
            .tint(.purple)
            .buttonStyle(.bordered)
            .disabled(!arrivalLocation.isEmpty &&
                      !departureLocation.isEmpty &&
                      price != 0.0 ? false : true)
            
            Spacer()
        }
        .padding()
    }
}
