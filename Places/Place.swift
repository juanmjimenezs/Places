//
//  Place.swift
//  Places
//
//  Created by Juan Manuel Jimenez Sanchez on 6/12/16.
//  Copyright © 2016 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Place: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var location: String
    @NSManaged var image: NSData?
    @NSManaged var phone: String?
    @NSManaged var web: String?
    @NSManaged var rating: String?
    
    /*init(name: String, type: String, location: String, image: UIImage, phone: String, web: String) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.web = web
    }*/
}
