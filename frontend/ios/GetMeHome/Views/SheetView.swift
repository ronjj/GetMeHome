//
//  SheetView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/26/23.
//

import SwiftUI

struct SheetView: View {
    
    @Binding var minTimeToggle: Bool
    @Binding var presentSheet: Bool
    @Binding var latestArrivalTimeToggle: Bool
    
    var body: some View {
        VStack{
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
