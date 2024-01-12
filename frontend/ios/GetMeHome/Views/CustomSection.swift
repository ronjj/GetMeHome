//
//  CustomSection.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/10/24.
//

import SwiftUI

enum ListType {
    case tripLocations
    case discountCodes
}

struct CustomSection: View {
    
    var sectionTitle: String
    var sectionText: Text?
    var sectionListType: ListType?
    var discountCodes: [Discount]?
    var trip: Trip?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sectionTitle)
                .font(.headline)
                .fontWeight(.bold)
            
            if sectionListType != nil {
                if sectionListType == .discountCodes {
                    VStack(alignment: .leading) {
                        ForEach(discountCodes!, id: \.self) { discountCode in
                            Text("- \(discountCode.code)")
                        }
                    }
                }
                if sectionListType == .tripLocations {
                    ForEach(trip!.intermediateStations, id: \.self) { station in
                        Text(station)
                    }
                }
            } else {
                sectionText
            }
        }
    }
}

