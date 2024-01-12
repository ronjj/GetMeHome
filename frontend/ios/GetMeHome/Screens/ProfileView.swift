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
    @AppStorage("earliestDepartureOnToggle") private var earliestDepartureOnToggle: Bool = false
    @AppStorage("latestArrivalOnToggle") private var latestArrivalOnToggle: Bool = false
    @AppStorage("setDefaultBusToggle") private var setDefaultBusToggle: Bool = false
    
    @AppStorage("earliestDepartureTime") private var earliestDepartureTime: Date = Date()
    @AppStorage("latestArrivalTime") private var latestArrivalTime: Date = Date()
    @AppStorage("selectedService") private var selectedService = "All"
    @AppStorage("removeTransfers") private var removeTransfers = false
    
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
                                   selection: $earliestDepartureTime,
                                   displayedComponents: .hourAndMinute)
                        .tint(.purple)
                    }
                    Toggle("Latest Arrival", isOn: $latestArrivalOnToggle)
                        .tint(.purple)
                    if latestArrivalOnToggle {
                        DatePicker("Latest Arrival Time",
                                   selection: $latestArrivalTime,
                                   displayedComponents: .hourAndMinute)
                        .tint(.purple)
                    }
                    Toggle("Remove Transfers", isOn: $removeTransfers)
                        .tint(.purple)
                    
                    Toggle("Bus Service", isOn: $setDefaultBusToggle)
                        .tint(.purple)
                    if setDefaultBusToggle {
                        Picker("Choose A Bus Service", selection: $selectedService) {
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
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Profile View")
        }
    }
}


//Need this extension to use Dates with AppStorage
//App Storage doesn't support Date types natively
//This code uses ISO8601DateFormatter to format a date to String and map it back.
//That formatter is static because creating and removing DateFormatters is an expensive operation.
extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
