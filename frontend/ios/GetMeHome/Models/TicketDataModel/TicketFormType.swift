//
//  TicketFormType.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/16/24.
//

import SwiftUI

enum FormType: Identifiable, View {
    case new(UIImage)
    case update(Ticket)
    
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new(let uiImage):
            return ImageFormView(viewModel: TicketFormViewModel(uiImage))
        case .update(let ticket):
            return ImageFormView(viewModel: TicketFormViewModel(ticket))
        }
    }
}
