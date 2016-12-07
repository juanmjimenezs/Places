//
//  Place.swift
//  Places
//
//  Created by Juan Manuel Jimenez Sanchez on 6/12/16.
//  Copyright © 2016 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import Foundation
import UIKit

class Place {
    var name = ""
    var type = ""
    var location = ""
    var image: UIImage!
    var rating = "rating"
    
    init(name: String, type: String, location: String, image: UIImage) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
    }
}
