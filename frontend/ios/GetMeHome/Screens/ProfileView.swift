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
    @Environment(\.colorScheme) var colorScheme
    private var email = SupportEmail(toAddress: "rj336@cornell.edu",
                                     subject: "Support Email",
                                     messageHeader: "Please Describe Your Issue Below")
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.black)
            }
            List {
                Section ("Set Search Defaults") {
                    if earliestDepartureOnToggle {
                        HStack {
                            DatePicker("Earliest Departure",
                                       selection: $earliestDepartureTime,
                                       displayedComponents: .hourAndMinute)
                            .tint(.purple)
                            Toggle("", isOn: $earliestDepartureOnToggle)
                                .tint(.purple)
                                .labelsHidden()
                        }
                    }   else {
                        HStack {
                            Text("Earliest Departure")
                            Spacer()
                            Toggle("", isOn: $earliestDepartureOnToggle)
                                .tint(.purple)
                                .labelsHidden()
                        }
                    }
                    
                    if latestArrivalOnToggle {
                        HStack {
                            DatePicker("Latest Arrival",
                                       selection: $latestArrivalTime,
                                       displayedComponents: .hourAndMinute)
                            .tint(.purple)
                            Toggle("", isOn: $latestArrivalOnToggle)
                                .tint(.purple)
                                .labelsHidden()
                        }
                    } else {
                        HStack {
                            Text("Latest Arrival")
                            Spacer()
                            Toggle("", isOn: $latestArrivalOnToggle)
                                .tint(.purple)
                                .labelsHidden()
                        }
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
                        withAnimation(.easeIn(duration: 1.0)) {
                            Button {
                                earliestDepartureOnToggle = false
                                latestArrivalOnToggle = false
                                setDefaultBusToggle = false
                                removeTransfers = false
                                AnalyticsManager.shared.logEvent(name: "ProfileView_ResetClicked")

                            } label: {
                                Text("Reset")
                            }
                            .tint(Color.red)
                        }
                    }
                }
                Section("Account") {
                    Text("Email: \(authViewModel.displayName)")
                    Button {
                        authViewModel.signOut()
                        AnalyticsManager.shared.logEvent(name: "LoginView_SignoutClicked")
                    } label: {
                        Text("Sign Out")
                    }
                    .tint(.red)
                }
                Section("Contact") {
                    Text("Have questions? Found bugs? Have a feature suggestion? Send me an email.")
                    Button {
                        email.send(openURL: openURL)
                        AnalyticsManager.shared.logEvent(name: "LoginView_SendEmailClicked")
                    } label: {
                        Text("Contact")
                    }
                    .tint(.purple)
                }
            }
            .background(colorScheme == .light ? .white : .black)
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .navigationTitle("Profile")
        }
        .analyticsScreen(name: "ProfileView")
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "ProfileView_Appear")
        }
    }
}

