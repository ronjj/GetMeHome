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
    @FetchRequest(sortDescriptors: [])
    private var tickets: FetchedResults<Ticket>
    @Environment(\.managedObjectContext) var moc
   
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
                        if let selectedImage = tickets.first(where: {$0.id == viewModel.id}) {
                            FileManager().deleteImage(with: selectedImage.imageID)
                            moc.delete(selectedImage)
                            try? moc.save()
                        }
                        dismiss()
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
                    if viewModel.updating {
                        if let id = viewModel.id, let selectedImage = tickets.first(where: {$0.id == id}) {
                            selectedImage.name = viewModel.name
                            FileManager().saveImage(with: id, image: viewModel.uiImage)
                            if moc.hasChanges {
                                try? moc.save()
                            }
                        }
                    } else {
                        let newImage = Ticket(context: moc)
                        newImage.name = viewModel.name
                        newImage.id = UUID().uuidString
                        try? moc.save()
                        FileManager().saveImage(with: newImage.imageID, image: viewModel.uiImage)
                    }
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

