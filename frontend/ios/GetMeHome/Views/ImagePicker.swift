//
//  ImagePicker.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/16/24.
//

import SwiftUI
import PhotosUI

@MainActor
class ImagePicker: ObservableObject {
    
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                try await loadTransferable(from: imageSelection)
            }
        }
    }
    @Published var image: Image?
    @Published var uiImage: UIImage?
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.uiImage = uiImage
                    self.image = Image(uiImage: uiImage)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
