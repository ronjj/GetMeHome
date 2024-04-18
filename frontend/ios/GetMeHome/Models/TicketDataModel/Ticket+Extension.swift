//
//  Ticket+Extension.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/15/24.
//

import UIKit

extension Ticket {
    var nameView: String {
        name ?? ""
    }
    
    var imageID: String {
        id ?? ""
    }
    
    var uiImage: UIImage {
        if !imageID.isEmpty,
           let image = FileManager().retreiveImage(with: imageID) {
            return image
        } else {
            return UIImage(systemName: "photo")!
        }
    }
}
