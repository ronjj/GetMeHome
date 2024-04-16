//
//  TicketFormViewModel.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/16/24.
//

import UIKit

class TicketFormViewModel: ObservableObject {
    @Published var name = ""
    @Published var uiImage: UIImage
    
    var id: String?
    
    var updating: Bool { id != nil}
    
    init(_ uiImage: UIImage) {
        self.uiImage = uiImage
    }
    
    init(_ ticket: Ticket) {
        name = ticket.nameView
        id = ticket.imageID
        uiImage = UIImage(systemName: "photo")!
    }
    
    var incomplete: Bool {
        name.isEmpty || uiImage == UIImage(systemName: "photo")!
    }
}
