//
//  MapDetailView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/10/24.
//

import SwiftUI

import SwiftUI
import MapKit

struct MapDetailView: View {
    
    var trip: Trip
    @Binding var mapDetailSelected: Bool
    
    @State private var arrivalCoordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @State private var departureCoordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @State private var mapSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    @State private var defaultMapType: MKMapType = .standard
    @State private var switchMapType: Bool = false
    
    var body: some View {
        VStack {
            DetailedMapView(
                arrivalCoordinates: $arrivalCoordinates,
                departureCoordinate: $departureCoordinates,
                span: $mapSpan,
                defaultMapType: $defaultMapType,
                switchMapType:  $switchMapType)
                .edgesIgnoringSafeArea(.all)
                .overlay(alignment: .topTrailing) {
                    VStack{
                        closeButton
                        
                        switchMapButton
                    }
                }
        }
        .onAppear {
            arrivalCoordinates.longitude = trip.arrivalLocationCoords.longitude
            arrivalCoordinates.latitude = trip.arrivalLocationCoords.latitude
            departureCoordinates.longitude = trip.departureLocationCoords.longitude
            departureCoordinates.latitude = trip.departureLocationCoords.latitude
        }
    }
}

extension MapDetailView {
    private var closeButton: some View {
        Button {
            mapDetailSelected.toggle()
        } label : {
            Text("close")
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .padding()
    }
    
    private var switchMapButton: some View {
        Button {
            switchMapType.toggle()
            
            if switchMapType {
                defaultMapType = .hybrid
            }
            
            if !switchMapType{
                defaultMapType = .standard
            }
        } label : {
            if defaultMapType == .standard {
                Image(systemName: "globe.americas")
                    .font(.title2)
                    .padding(16)
                    .foregroundColor(.primary)
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding()
            } else {
                Image(systemName: "pencil.and.outline")
                    .font(.title2)
                    .padding(16)
                    .foregroundColor(.primary)
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding()
            }
        }
    }
}
