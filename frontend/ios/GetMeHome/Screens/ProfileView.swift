//
//  ProfileView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/11/24.
//

import SwiftUI

struct ProfileView: View {
    
    var viewModel = ViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var earliestDepartureOnToggle: Bool = false
    @State private var latestArrivalOnToggle: Bool = false
    @State private var setDefaultBusToggle: Bool = false
    
    @State private var earliestDepartureTime: Date? = nil
    @State private var latestArrivalTime: Date? = nil
    @State private var selectedService = "All"

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Profile View")
                    .font(.title)
                    .fontWeight(.black)
                Text("Signed in as \(authViewModel.displayName)")
                Button {
                    authViewModel.signOut()
                } label: {
                    Text("Sign Out")
                }
            }
           
            List {
                Section ("Search Defaults") {
                    
                    Toggle("Earliest Departure On", isOn: $earliestDepartureOnToggle)
                        .tint(.purple)
                    if earliestDepartureOnToggle {
                        DatePicker("Earliest Departure Time",
    //                               Need complicated binding so I can make earliestDeparture nil
                                   selection: Binding<Date>(get: {self.earliestDepartureTime ?? Date()}, set: {self.earliestDepartureTime = $0}),
                                   displayedComponents: .hourAndMinute)
                            .tint(.purple)
                    }
                    Toggle("Latest Arrival On", isOn: $latestArrivalOnToggle)
                        .tint(.purple)
                    if latestArrivalOnToggle {
                        DatePicker("Latest Arrival Time",
                                   selection: Binding<Date>(get: {self.latestArrivalTime ?? Date()}, set: {self.latestArrivalTime = $0}),
                                   displayedComponents: .hourAndMinute)
                            .tint(.purple)
                    }
                    Toggle("Set Default Bus Service", isOn: $setDefaultBusToggle)
                        .tint(.purple)
                    if setDefaultBusToggle {
                        Picker("Choose A Bus Service", selection: $selectedService) {
                            ForEach(viewModel.services, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.palette)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profile View")
        }
    }
}
