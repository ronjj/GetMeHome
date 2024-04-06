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
    var trip: Trip?
    var discountCodes: [Discount]?
   
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
               
                if (trip != nil) {
                    ForEach(trip!.intermediateStations, id: \.self) { station in
                        Text(station)
                            .font(.body)
                            .foregroundStyle(.secondary)
                        Divider()
                    }
                }
                if discountCodes != nil {
                    ForEach(discountCodes!, id: \.self) { discountCode in
                        Text("\(discountCode.code)")
                            .font(.body)
                            .foregroundStyle(.secondary)
                        Divider()
                    }
                }
            }
        }
        .padding()
    }
}

