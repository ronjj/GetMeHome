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
    @State private var location = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.507222,
            longitude: -0.1275),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5)))
    @State var mapType: MKMapType = .standard
    @State var switchMapType: Bool = false
    @State var mapDetailSelected: Bool = false
    @Namespace var mapScope
    
    @State private var selectedMarker: Int?
    
    @State var arrivalCoordinates: CLLocationCoordinate2D
    @State var departureCoordinates: CLLocationCoordinate2D
    var trip: Trip
    @State private var showDetails = false
    
    
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
   
    var body: some View {
        Map(position: $location, selection: $selectedMarker) {
            Marker("Arrival Location", systemImage: "star.fill", coordinate: arrivalCoordinates)
                .tint(.purple)
                .tag(1)
            Marker("Departure Location", systemImage: "bus.fill", coordinate: departureCoordinates)
                .tint(.purple)
                .tag(2)
            
//            need to ask for users location for this
//            UserAnnotation()
            
            if let route {
                MapPolyline(route.polyline)
                    .stroke(.purple, lineWidth: 6)
            }
        }
        .mapControls {
            MapPitchToggle()
        }
        .mapStyle(switchMapType ? .hybrid(elevation:.realistic) : .standard(elevation:.realistic))
        .overlay(alignment: .topLeading) {
            VStack (spacing: 2){
                closeButton
                switchMapButton
//                MapUserLocationButton(scope: mapScope)
            }
            .padding()
            .mapScope(mapScope)
        }
        .analyticsScreen(name: "MapViewDetailSheet")
        .overlay(alignment: .topLeading) {
            VStack (spacing: 10) {
                MapPitchToggle(scope: mapScope)
            }
            .padding()
            .mapScope(mapScope)
            
        }
        .onAppear {
                let mapSpan = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
                let coordinates = (MKCoordinateRegion(center: arrivalCoordinates, span: mapSpan))
                location = MapCameraPosition.region(coordinates)
            fetchRoute()
        }
    }
}

extension MapViewDetailSheet {

    func fetchRoute() {
        let request = MKDirections.Request()
        request.destination = MKMapItem(placemark: .init(coordinate: arrivalCoordinates))
        request.source = MKMapItem(placemark: .init(coordinate: departureCoordinates))
        
        Task {
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            routeDestination = MKMapItem(placemark: .init(coordinate: departureCoordinates))
        }
    }

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
            AnalyticsManager.shared.logEvent(name: "MapViewDetailSheet_SwitchMapClicked")

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
