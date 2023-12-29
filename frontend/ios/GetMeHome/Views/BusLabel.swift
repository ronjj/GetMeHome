//
//  BusLabel.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 12/29/23.
//

import SwiftUI

struct BusLabel: View {
    var busService: String
    
    var body: some View {
        switch busService {
        case "FlixBus":
            Button("FlixBus") {}
            .buttonStyle(.bordered)
            .tint(.blue)
        case "OurBus":
            Button("OurBus") {}
            .buttonStyle(.bordered)
            .tint(.green)
        case "MegaBus":
            Button("MegaBus") {}
                .buttonStyle(.bordered)
                .tint(.red)
        default:
            Text("No Bus Service")
        }
    }
}
