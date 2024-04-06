//
//  TripDetailView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/24/23.
//

import SwiftUI
import MapKit

struct TripDetailView: View {
    
    var trip: Trip
    var discountCodes: [Discount]
    var viewModel = ViewModel()
    var paymentsViewModel = PaymentsViewModel()
    var averageTripPrice: Float
    let blankDiscount =  [Discount(id: 1, service: "FlixBus", code: "None")]

    @State private var date = Date()
    @State private var discountCodesFiltered = [Discount]()

    @State private var location = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    @State private var mapDetailSelected = false
    
    var body: some View {
        ScrollView {
                if trip.arrivalLocationCoords.latitude != 0.0 {
                    Map(position: $location) {
                        Marker("Departure Location",
                               systemImage: "bus.fill",
                               coordinate: CLLocationCoordinate2D(
                                latitude: trip.departureLocationCoords.latitude,
                                longitude: trip.departureLocationCoords.longitude))
                        .tint(.purple)
                        
                        Marker("Arrival Location",
                               systemImage: "star.fill",
                               coordinate: CLLocationCoordinate2D(
                                latitude: trip.arrivalLocationCoords.latitude,
                                longitude: trip.arrivalLocationCoords.longitude))
                        .tint(.purple)
                    }
                    
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fill)
                    .ignoresSafeArea()
                    .onTapGesture {
                        mapDetailSelected.toggle()
                        AnalyticsManager.shared.logEvent(name: "TripDetailView_MapClicked")
                    }
                    .overlay(alignment: .topTrailing) {
                        Button {
                            mapDetailSelected.toggle()
                            AnalyticsManager.shared.logEvent(name: "TripDetailView_ExpandMapButtonClicked")
                            
                        } label: {
                            Image(systemName: "arrow.up.backward.and.arrow.down.forward.circle.fill")
                                .font(.headline)
                                .padding(16)
                                .foregroundColor(.primary)
                                .background(.thickMaterial)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                                .padding()
                                .rotationEffect(Angle(degrees: 270))
                                .buttonStyle(.bordered)
                        }
                    }
                }
            
            VStack(alignment: .leading, spacing: 5) {
                 
                HStack {
                    TripDetailSection(title: "Price", bodyText:  Text("$\(trip.price, specifier: "%.2f")"), subText: Text("Average Price For Trip: $\(averageTripPrice, specifier: "%.2f")"))
                    
                    Spacer()
                    
                    TripDetailSection(title: "Bus Service", bodyText:  Text("\(trip.busService)"))
                }
              
                HStack {
                    TripDetailSection(title: "Date", bodyText:  Text(viewModel.convertToDate(dateString: trip.date),
                                                                     style: .date))
                    Spacer()
                    
                    TripDetailSection(title: "Time", bodyText: Text("\(trip.departureTime) - \(trip.arrivalTime)"))
                }
                
                TripDetailSection(title: "Departure", bodyText:  Text("\(trip.departureLocation)"))
                
                TripDetailSection(title: "Destination", bodyText:  Text("\(trip.arrivalLocation)"))
               
                TripDetailSection(title: "Bus Destinations", trip: trip)

                if !discountCodes.isEmpty {
                    TripDetailSection(title: "Discount Codes", discountCodes: discountCodes)
                }
                
                
                HStack {
                    Link("Buy on \(trip.busService) Website", 
                         destination: (URL(string: trip.ticketLink) ?? URL(string: viewModel.backupLinkMap[trip.busService]!))!)
                        .buttonStyle(.bordered)
                        .tint(.indigo)
                        .frame(maxWidth: .infinity)
//                    Button {
//                        paymentsViewModel.makePayment(date: trip.date,
//                                                      price: String(trip.price),
//                                                      dep: trip.departureLocation,
//                                                      depTime: trip.departureTime,
//                                                      dest: trip.arrivalLocation,
//                                                      destTime: trip.arrivalTime,
//                                                      bus: trip.busService,
//                                                      name: "Ronald Jabouin",
//                                                      email: "ronaldjabouin2004@gmail.com",
//                                                      commission: String(trip.price * 0.05),
//                                                      ticketLink: trip.ticketLink)
//                    } label: {
//                        Text("Send Post request")
//                    }
//                        .buttonStyle(.bordered)
//                        .tint(.indigo)
//                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .analyticsScreen(name: "TripDetailView")
        .sheet(isPresented: $mapDetailSelected) {
            MapViewDetailSheet(arrivalCoordinates:
                                CLLocationCoordinate2D(
                                    latitude: trip.arrivalLocationCoords.latitude,
                                    longitude:  trip.arrivalLocationCoords.longitude) ,
                               departureCoordinates:
                                CLLocationCoordinate2D(
                                    latitude: trip.departureLocationCoords.latitude,
                                    longitude:  trip.departureLocationCoords.longitude), trip: trip)
        }
        .onAppear(perform: {
            let filteredCodesForService = discountCodes.filter({$0.service == trip.busService})
            discountCodesFiltered = filteredCodesForService
            
            let coordinates = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trip.arrivalLocationCoords.latitude, longitude: trip.arrivalLocationCoords.longitude), span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12))
            location = MapCameraPosition.region(coordinates)
            AnalyticsManager.shared.logEvent(name: "TripDetailView_Appear")
            
            
        })
        .listStyle(.plain)
    }
}

