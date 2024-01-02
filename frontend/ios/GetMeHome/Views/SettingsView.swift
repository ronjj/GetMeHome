//
//  SheetView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/26/23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var minTimeToggle: Bool
    @Binding var presentSheet: Bool
    @Binding var latestArrivalTimeToggle: Bool
    @Binding var busService: String
    
    var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                Section("Choose A Bus Service") {
                    Picker("Choose A Bus Service", selection: $busService) {
                        ForEach(viewModel.services, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.palette)
                    
                }
            }
            Toggle("Set Earliest Departure Time", isOn: $minTimeToggle)
                .tint(.purple)
            Toggle("Set Latest Arrival Time", isOn: $latestArrivalTimeToggle)
                .tint(.purple)
           
            Spacer()
        }
        .padding()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Close"){
                    presentSheet = false
                }
                .tint(.purple)
            }
        }
    }
}
