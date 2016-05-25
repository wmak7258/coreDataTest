//
//  Entity.swift
//  recipes
//
//  Created by student1 on 5/23/16.
//  Copyright © 2016 mobileapps. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Entity: NSManagedObject {
    
    @NSManaged var address: String?
    @NSManaged var name: String?
    
    convenience init() {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let item = NSEntityDescription.entityForName("Entity", inManagedObjectContext: context)
        self.init(entity: item!, insertIntoManagedObjectContext: context)
    }
}
