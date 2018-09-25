//
//  Contacts+CoreDataClass.swift
//  PhoneBool
//
//  Created by Andrii Pyvovarov on 14.09.18.
//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Contacts)
public class Contacts: NSManagedObject {
    convenience init() {
        // Описание сущности
        
        // Создание нового объекта
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Contacts"), insertInto: CoreDataManager.instance.managedObjectContext)
    }

}
