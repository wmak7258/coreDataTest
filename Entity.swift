//
//  Entity.swift
//  recipes
//
//  Created by student1 on 5/23/16.
//  Copyright © 2016 mobileapps. All rights reserved.
//

import Foundation
import CoreData


class Entity: NSManagedObject {
    
    @NSManaged var address: String?
    @NSManaged var name: String?
    
}
