//
//  LoadingView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 11/25/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Spacer()
        VStack {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.indigo)
                .scaleEffect(2)
                .padding(.bottom, 10)
            
            Text("Loading Trips")
                .bold()
        }
        Spacer()
    }
}

#Preview {
    LoadingView()
}
