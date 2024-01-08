//
//  FilterRowView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/8/24.
//

import SwiftUI

struct FilterRowView: View {
    
    @State var departureTimeSelected: Bool = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button {
                    departureTimeSelected.toggle()
                } label: {
                    FilterButton(buttonTitle: "Departure Time", isSelected: $departureTimeSelected)
                }
            }
        }
    }
}

struct FilterButton: View {
    
    var buttonTitle: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(buttonTitle)
            .frame(height: 30)
            .padding(.horizontal)
            .foregroundColor(isSelected ? .white : .black)
            .background(isSelected ? .purple : .gray.opacity(0.5))
            .cornerRadius(10)
           
    }
}
