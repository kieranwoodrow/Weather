//
//  Location+CoreDataProperties.swift
//  Weather
//
//  Created by Kieran Woodrow on 2022/04/28.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?

}

extension Location : Identifiable {

}
