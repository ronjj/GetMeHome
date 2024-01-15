//
//  SavedTrip+CoreDataProperties.swift
//  GetMeHome
//
//  Created by Ronald Jabouin on 1/15/24.
//
//

import Foundation
import CoreData


extension SavedTrip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedTrip> {
        return NSFetchRequest<SavedTrip>(entityName: "SavedTrip")
    }

    @NSManaged public var id: Int16
    @NSManaged public var date: String?
    @NSManaged public var price: Float
    @NSManaged public var arrivalTime: String?
    @NSManaged public var arrivalLocation: String?
    @NSManaged public var departureTime: String?
    @NSManaged public var departureLocation: String?
    @NSManaged public var busService: String?
    @NSManaged public var nonStop: String?
    @NSManaged public var ticketLink: String?
    @NSManaged public var intermediateCount: Int16
    @NSManaged public var intermediateStations: String?
    @NSManaged public var arrivalLat: Float
    @NSManaged public var arrivalLongitude: String?
    @NSManaged public var departureLat: String?
    @NSManaged public var departureLongitude: String?

}

extension SavedTrip : Identifiable {

}
