//
//  TripDetailViewSections.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/5/24.
//

import SwiftUI

struct TripDetailSection: View {
    
    var title: String
    var bodyText: Text?
    var subText: Text?
    var list: [String]?
   
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Text(title)
                    .font(.title)
                    .bold()
                bodyText
                    .font(.body)
                    .foregroundStyle(.secondary)
                subText
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

