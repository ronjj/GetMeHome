//
//  ImageFormView.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/16/24.
//

import SwiftUI
import PhotosUI

struct ImageFormView: View {
    
    @ObservedObject var viewModel: TicketFormViewModel
    @StateObject var imagePicker = ImagePicker()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text(viewModel.updating ? "Update Image" : "New Image")
            HStack{
                Button{
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                if viewModel.updating {
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
            }
            Image(uiImage: viewModel.uiImage)
                .resizable()
                .scaledToFit()
            TextField("Image Name", text: $viewModel.name)

            HStack {
                if viewModel.updating {
                    PhotosPicker("Change Name",
                                 selection: $imagePicker.imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared())
                    .buttonStyle(.bordered)
                }
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }
                .tint(.green)
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.incomplete)
            }
            Spacer()
        }
        .padding()
        .onChange(of: imagePicker.uiImage) { newImage in
            if let newImage {
                viewModel.uiImage = newImage
            }
        }
    }
}

