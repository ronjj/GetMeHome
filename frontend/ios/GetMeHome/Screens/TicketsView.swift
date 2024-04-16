//
//  TicketsView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/15/24.
//

import SwiftUI
import PhotosUI

struct TicketsView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var tickets: FetchedResults<Ticket>
    @StateObject private var imagePicker = ImagePicker()
    var body: some View {
        VStack {
            Group {
                if !tickets.isEmpty {

                } else {
                    Text("Select an image")
                }
            }
            PhotosPicker("New Image", selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared())
                .buttonStyle(.borderedProminent)
            
        }
    }
}

