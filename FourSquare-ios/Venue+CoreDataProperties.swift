//
//  Venue+CoreDataProperties.swift
//  
//
//  Created by mohammad on 8/22/20.
//
//

import Foundation
import CoreData


extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var address: String?
    @NSManaged public var categoryName: String?
    @NSManaged public var categoryURL: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
