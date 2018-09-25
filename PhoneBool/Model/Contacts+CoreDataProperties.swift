//
//  Contacts+CoreDataProperties.swift
//  PhoneBool
//
//  Created by Andrii Pyvovarov on 14.09.18.
//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var surname: String?
    @NSManaged public var email: String?
    @NSManaged public var company: String?
    @NSManaged public var photo: NSData?

}
