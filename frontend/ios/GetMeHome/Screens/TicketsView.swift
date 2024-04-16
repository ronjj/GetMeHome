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
    @State private var formType: FormType?
    
    var body: some View {
        VStack {
            Group {
                if !tickets.isEmpty {

                } else {
                    Text("Select an image")
                }
            }
            .onChange(of: imagePicker.uiImage) { newImage in
                if let newImage {
                    formType = .new(newImage)
                }
            }
            
            PhotosPicker("New Image", selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared())
                .buttonStyle(.borderedProminent)
                
        }
    }
}

