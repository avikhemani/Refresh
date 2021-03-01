//
//  Task.swift
//  Refresh
//
//  Created by Avi Khemani on 2/21/21.
//

import Foundation
import UIKit

class Task: Codable {
    
    var name: String
    var shape: Shape
    var color: RColor
    var width: Int
    var height: Int
    
    init(name: String, shape: Shape, color: RColor, width: Int, height: Int) {
        self.name = name
        self.shape = shape
        self.color = color
        self.width = width
        self.height = height
    }
    
}
