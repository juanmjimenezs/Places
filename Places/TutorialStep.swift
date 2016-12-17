//
//  TutorialStep.swift
//  Places
//
//  Created by Juan Manuel Jimenez Sanchez on 15/12/16.
//  Copyright © 2016 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import Foundation
import UIKit

class TutorialStep: NSObject {
    var index = 0
    var heading = ""
    var content = ""
    var image: UIImage!
    
    init(index: Int, heading: String, content: String, image: UIImage) {
        self.index = index
        self.heading = heading
        self.content = content
        self.image = image
    }
}
