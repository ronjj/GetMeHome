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
    
    var arrivalCoordinates: CLLocationCoordinate2D
    var departureCoordinates: CLLocationCoordinate2D
    var trip: Trip
    @State private var results = [MKMapItem]()
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
            
            UserAnnotation()
            
            if let route {
                MapPolyline(route.polyline)
                    .stroke(.purple, lineWidth: 6)
            }
        }
        .mapControls {
            MapPitchToggle()
        }
        .mapStyle(switchMapType ? .hybrid(elevation:.realistic) : .standard(elevation:.realistic))
        .overlay(alignment: .bottomTrailing) {
            HStack{
                closeButton
                switchMapButton
                MapUserLocationButton(scope: mapScope)
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
            Task {await searchPlaces()}
            fetchRoute()
            print(results)
            
        }
        .onChange(of: selectedMarker, { oldValue, newValue in
                showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            LocationDetailView(show: $showDetails)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        })
    }
}

struct LocationDetailView: View {
    
//    @Binding var mapSelection: MKMapItem?
    @Binding var show: Bool
    @State private var lookAroundScene: MKLookAroundScene?
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading) {
//                    Text(mapSelection?.placemark.name ?? "")
                    Text("Some text")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
//                    Text(mapSelection?.placemark.title ?? "")
                    Text("Some text")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .padding(.trailing)
                }
                
                Spacer()
                
                Button {
                    show.toggle()
//                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray)
                }
            }
            
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
            }
        }
    }
}

extension LocationDetailView {
//    func fetchLookAroundPreview() {
//        if let mapSelection {
////        if let show {
//            lookAroundScene = nil
//            Task {
//                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
//                lookAroundScene = try? await request.scene
//            }
//        }
//    }
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
            
//            withAnimation(.snappy) {
//                routeDisplaying = true
//                showDetails = false
//                
//                if let rect = route?.polyline.boundingMapRect, routeDisplaying {
//                    location = .rect(rect)
//                }
//            }
        }
    }
    func searchPlaces() async {
//        if trip.arrivalLocationCoords.latitude != 0.0 {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = trip.arrivalLocation
            request.region = MKCoordinateRegion(center: arrivalCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
            
            let results = try? await MKLocalSearch(request: request).start()
            self.results = results?.mapItems ?? []
//        }
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
