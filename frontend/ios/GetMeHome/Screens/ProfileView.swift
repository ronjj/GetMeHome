//
//  ProfileView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/11/24.
//

import SwiftUI

struct ProfileView: View {

    @AppStorage("earliestDepartureOnToggle") private var earliestDepartureOnToggle: Bool = false
    @AppStorage("latestArrivalOnToggle") private var latestArrivalOnToggle: Bool = false
    @AppStorage("setDefaultBusToggle") private var setDefaultBusToggle: Bool = false
    @AppStorage("earliestDepartureTime") private var earliestDepartureTime: Date = Date()
    @AppStorage("latestArrivalTime") private var latestArrivalTime: Date = Date()
    @AppStorage("selectedService") private var selectedService = "All"
    @AppStorage("removeTransfers") private var removeTransfers = false
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var viewModel = ViewModel()
    
    @Environment(\.openURL) var openURL
    private var email = SupportEmail(toAddress: "rj336@cornell.edu",
                                     subject: "Support Email",
                                     messageHeader: "Please Describe Your Issue Below")
    
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
                Section ("Set Search Defaults") {
                    Toggle("Earliest Departure", isOn: $earliestDepartureOnToggle)
                        .tint(.purple)
                    if earliestDepartureOnToggle {
                        DatePicker("Earliest Departure",
                                   selection: $earliestDepartureTime,
                                   displayedComponents: .hourAndMinute)
                        .tint(.purple)
                    }
                    Toggle("Latest Arrival", isOn: $latestArrivalOnToggle)
                        .tint(.purple)
                    if latestArrivalOnToggle {
                        DatePicker("Latest Arrival",
                                   selection: $latestArrivalTime,
                                   displayedComponents: .hourAndMinute)
                        .tint(.purple)
                    }
                    Toggle("Remove Transfers", isOn: $removeTransfers)
                        .tint(.purple)
                    
                    Toggle("Bus Service", isOn: $setDefaultBusToggle)
                        .tint(.purple)
                    if setDefaultBusToggle {
                        Picker("Bus Service", selection: $selectedService) {
                            ForEach(viewModel.services, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.palette)
                    }
                    
                    if earliestDepartureOnToggle || latestArrivalOnToggle || removeTransfers || setDefaultBusToggle {
                        Button {
                            earliestDepartureOnToggle = false
                            latestArrivalOnToggle = false
                            setDefaultBusToggle = false
                            removeTransfers = false
                            
                        } label: {
                            Text("Reset")
                        }
                        .tint(.red)
                    }
                }
                Section("Contact") {
                    Text("Have questions, founds bugs, have a feature suggestion? Send me an email.")
                    Button {
                        email.send(openURL: openURL)
                    } label: {
                        Text("Contact")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profile View")
        }
    }
}

