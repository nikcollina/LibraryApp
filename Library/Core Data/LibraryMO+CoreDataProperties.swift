//
//  LibraryMO+CoreDataProperties.swift
//  Library
//
//  Created by Nikolas Collina on 10/29/20.
//
//

import Foundation
import CoreData


extension LibraryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LibraryMO> {
        return NSFetchRequest<LibraryMO>(entityName: "LibraryMO")
    }

    @NSManaged public var books: Set<BookMO>

}

// MARK: Generated accessors for books
extension LibraryMO {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: BookMO)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: BookMO)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension LibraryMO : Identifiable {

}
