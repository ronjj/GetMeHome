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
   
    @AppStorage("departureLocationOnToggle") private var departureLocationOnToggle = false
    @AppStorage("departureLocation") private var departureLocation: String = "Ithaca"
    @AppStorage("arrivalLocationOnToggle") private var arrivalLocationOnToggle = false
    @AppStorage("arrivalLocation") private var arrivalLocation: String = "NYC"
    
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
                    
                    if departureLocationOnToggle {
                        HStack {
                            Text("Departure Location")
                            Spacer()
                            Menu(departureLocation) {
                                //                    Have to sort dict to iterate over it in SwiftUI. not actually necessary to sort
                                ForEach(viewModel.locationQueryMap.sorted(by: >), id: \.key)  { location, code in
                                    if departureLocation != location && arrivalLocation != location {
                                        Button("\(location)") {
                                            departureLocation = location
                                            AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_DepLocClicked")
                                            AnalyticsManager.shared.logEvent(name: "DateAndLocationPickerView_\(location)Clicked")
                                            
                                        }
                                        .buttonStyle(.bordered)
                                    }
                                }
                            }
                            .tint(.purple)
                            Toggle("", isOn: $departureLocationOnToggle)
                                .tint(.purple)
                                .labelsHidden()
                        }
                    } else {
                        HStack {
                            Text("Departure Location")
                            Spacer()
                            Toggle("", isOn: $departureLocationOnToggle)
                                .tint(.purple)
                                .labelsHidden()
                        }
                    }
                    
                    if arrivalLocationOnToggle {
                        HStack {
                            Text("Arrival Location")
                            Spacer()
                            Menu(arrivalLocation) {
                                //                    Have to sort dict to iterate over it in SwiftUI. not actually necessary to sort
                                ForEach(viewModel.locationQueryMap.sorted(by: >), id: \.key)  { location, code in
                                    if arrivalLocation != location && departureLocation != location {
                                        Button("\(location)") {
                                            arrivalLocation = location
                                            AnalyticsManager.shared.logEvent(name: "ProfileView_ArrLocClicked")
                                            AnalyticsManager.shared.logEvent(name: "ProfileView_\(location)Clicked")
                                        }
                                        .buttonStyle(.bordered)
                                    }
                                }
                            }
                            .tint(.purple)
                            Toggle("", isOn: $arrivalLocationOnToggle)
                                .tint(.purple)
                                .labelsHidden()
                        }
                    } else {
                        HStack {
                            Text("Arrival Location")
                            Spacer()
                            Toggle("", isOn: $arrivalLocationOnToggle)
                                .tint(.purple)
                                .labelsHidden()
                        }
                    }
                    
                    if arrivalLocationOnToggle && departureLocationOnToggle {
                        Button {
                            viewModel.swapLocations(swap: &departureLocation, with: &arrivalLocation)
                            AnalyticsManager.shared.logEvent(name: "ProfileView_SwapClicked")
                        } label: {
                            Text("Swap Departure and Arrival Location")
                        }
                        .tint(.purple)
                    }
                    
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
                    if earliestDepartureOnToggle || latestArrivalOnToggle || removeTransfers || setDefaultBusToggle || departureLocationOnToggle || arrivalLocationOnToggle {
                        withAnimation(.easeIn(duration: 1.0)) {
                            Button {
                                earliestDepartureOnToggle = false
                                latestArrivalOnToggle = false
                                setDefaultBusToggle = false
                                removeTransfers = false
                                departureLocationOnToggle = false
                                arrivalLocationOnToggle = false
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
                        AnalyticsManager.shared.logEvent(name: "ProfileView_SignoutClicked")
                    } label: {
                        Text("Sign Out")
                    }
                    .tint(.red)
                }
                Section("Contact") {
                    Text("Have questions? Found bugs? Have a feature suggestion? \nLet Me Know!")
                    Button {
                        email.send(openURL: openURL)
                        AnalyticsManager.shared.logEvent(name: "ProfileView_SendEmailClicked")
                    } label: {
                        Text("Contact Via Email")
                    }
                    .tint(.purple)
                    
                    Link("Google Form", destination: URL(string: "https://forms.gle/hLKQ1xjt9WGW8wBW8")!)
                        .tint(.purple)
                        .onTapGesture(perform: {
                            AnalyticsManager.shared.logEvent(name: "ProfileView_GoogleFormClicked")
                        })
                }
            }
            .background(colorScheme == .light ? .white : .black)
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
        }
        .analyticsScreen(name: "ProfileView")
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "ProfileView_Appear")
        }
    }
}

