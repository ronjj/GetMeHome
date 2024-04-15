//
//  TicketContainer.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 4/15/24.
//

import Foundation
import CoreData

class TicketContainer {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name:"TicketContainer")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
