//
//  TicketsView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/15/24.
//

import SwiftUI

struct TicketsView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var tickets: FetchedResults<Ticket>
    var body: some View {
        VStack {
            Group {
                if !tickets.isEmpty {

                } else {
                    Text("Select an image")
                }
            }
        }
    }
}

