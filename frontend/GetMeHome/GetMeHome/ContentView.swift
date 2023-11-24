//
//  ContentView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/23/23.
//

import SwiftUI

struct Trip: Hashable {
    let date: String
    let price: Float
    let arrival_time: String
    let arrival_location: String
    let departure_time: String
    let departure_location: String
    let bus_service: String
    let non_stop: String
}

//Add some protection that origin and arrival destination can't be the same
var locations: [String] = ["Ithaca", "New York"]

struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                HStack{
                    DatePicker("Choose Trip  Date", selection: $selectedDate)
//                    Picker for departure location
                    Image(systemName: "arrow.forward")
//                    Picker for arrival location
                }
            }
            
        }
        .padding()
        .navigationTitle("GetMeHome")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
