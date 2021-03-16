//
//  BookMO+CoreDataProperties.swift
//  Library
//
//  Created by Nikolas Collina on 10/29/20.
//
//

import Foundation
import CoreData


extension BookMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookMO> {
        return NSFetchRequest<BookMO>(entityName: "BookMO")
    }

    @NSManaged public var author: String?
    @NSManaged public var country: String
    @NSManaged public var currentPage: String
    @NSManaged public var currentPageInt: Int
    @NSManaged public var image: String
    @NSManaged public var language: String
    @NSManaged public var link: String
    @NSManaged public var pages: Int
    @NSManaged public var reading: Bool
    @NSManaged public var title: String
    @NSManaged public var year: Int
    @NSManaged public var notes: Set<NoteMO>
    @NSManaged public var library: LibraryMO

}

// MARK: Generated accessors for notes
extension BookMO {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: NoteMO)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: NoteMO)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension BookMO : Identifiable {

}
