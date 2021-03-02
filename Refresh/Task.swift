//
//  Task.swift
//  Refresh
//
//  Created by Avi Khemani on 2/21/21.
//

import Foundation
import UIKit

class Task: Codable, Equatable {

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
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name && lhs.shape == rhs.shape && lhs.color == rhs.color && lhs.width == rhs.width && lhs.height == rhs.height
    }
    
    
    
}
