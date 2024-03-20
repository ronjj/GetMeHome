//
//  FilterScreen.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 3/20/24.
//

import SwiftUI

struct FilterScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                }
                .tint(.blue)
            }
            .padding()
            
            Text("Filter Screen")
                .font(.title)
                .fontWeight(.bold)
            
            Section("Departure Time") {
                Text("change dep time")
            }
            
            Spacer()
        }
    }
}

