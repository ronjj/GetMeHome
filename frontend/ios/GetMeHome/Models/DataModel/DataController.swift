//
//  DataController.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//

import Foundation
import CoreData

class DataContrller: ObservableObject {
    let container = NSPersistentContainer(name:"SavedTripModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Error saving \(error.localizedDescription)")
        }
    }
//    func delete(context: NSManagedObjectContext, trip: SavedTrip) {
//        do {
//            try context.delete(trip)
//            print("Data removed")
//        } catch {
//            print("Error removing \(error.localizedDescription)")
//        }
//    }
//    
//    func removeTrip(savedTrip: SavedTrip, context: NSManagedObjectContext) {
//        delete(context: context, trip: savedTrip)
//    }
    
    func addSavedTrip(arrivalLocation: String,
                      arrivalTime: String,
                      busService: String,
                      date: String,
                      departureLocation: String,
                      departureTime: String,
                      id: Int,
                      nonStop: String,
                      price: Float,
                      ticketLink: String,
                      context: NSManagedObjectContext) {
        let savedTrip = SavedTrip(context: context)
        savedTrip.id = Int16(id)
        savedTrip.arrivalLocation = arrivalLocation
        savedTrip.arrivalTime = arrivalTime
        savedTrip.busService = busService
        savedTrip.date = date
        savedTrip.departureLocation = departureLocation
        savedTrip.departureTime = departureTime
        savedTrip.nonStop = nonStop
        savedTrip.price = price
        savedTrip.ticketLink = ticketLink
        
        save(context: context)
        
    }
}
