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
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        VStack {
            Group {
                if !tickets.isEmpty {
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(tickets) { ticket in
                                Button {
                                    formType = .update(ticket)
                                } label: {
                                    VStack{
                                        
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                } else {
                    Text("Select an image")
                }
            }
            .onChange(of: imagePicker.uiImage) { newImage in
                if let newImage {
                    formType = .new(newImage)
                }
            }
            .sheet(item: $formType) { $0 }
            PhotosPicker("New Image", selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared())
                .buttonStyle(.borderedProminent)
                
        }
    }
}

