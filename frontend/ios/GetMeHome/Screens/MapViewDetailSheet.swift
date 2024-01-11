//
//  MapViewDetailSheet.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/11/24.
//

import SwiftUI
import MapKit

struct MapViewDetailSheet: View {
    
    @Environment(\.dismiss) var dismiss
     
    //   TODO: make these the coords for cornell
    @State private var location = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    @State var mapType: MKMapType = .standard
    @State var switchMapType: Bool = false
    @State var mapDetailSelected: Bool = false
    @Namespace var mapScope
    
    var arrivalCoordinates: CLLocationCoordinate2D
    var departureCoordinates: CLLocationCoordinate2D
   
    var body: some View {
        Map(position: $location) {
            Marker("Arrival Location", coordinate: arrivalCoordinates)
                .tint(.purple)
            Marker("Departure Location", coordinate: departureCoordinates)
                .tint(.purple)
        }
        .mapStyle(switchMapType ? .hybrid : .standard)
        .mapControls {
            MapCompass()
        }
        .overlay(alignment: .topLeading) {
            VStack{
                closeButton
                switchMapButton
            }
        }
        .onAppear {
                let mapSpan = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
                let coordinates = (MKCoordinateRegion(center: arrivalCoordinates, span: mapSpan))
                location = MapCameraPosition.region(coordinates)
        }
    }
}

extension MapViewDetailSheet {
    private var closeButton: some View {
        Button {
            dismiss()
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
                mapType = .hybrid
            } else {
                mapType = .standard
            }
        } label : {
            if mapType == .standard {
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
