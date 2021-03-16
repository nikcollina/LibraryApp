//
//  NoteMO+CoreDataProperties.swift
//  Library
//
//  Created by Nikolas Collina on 10/29/20.
//
//

import Foundation
import CoreData


extension NoteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteMO> {
        return NSFetchRequest<NoteMO>(entityName: "NoteMO")
    }

    @NSManaged public var progress: String
    @NSManaged public var text: String
    @NSManaged public var time: Date
    @NSManaged public var book: BookMO

}

extension NoteMO : Identifiable {

}
