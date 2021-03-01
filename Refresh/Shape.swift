//
//  Shape.swift
//  Refresh
//
//  Created by Avi Khemani on 2/21/21.
//

import Foundation

enum Shape: String, CaseIterable, Codable {
    
    case circle
    case square
    case rectangle
    case triangle
    case star
    
    var iconString: String {
        switch self {
        case .circle: return "circleIcon"
        case .square: return "squareIcon"
        case .rectangle: return "rectangleIcon"
        case .triangle: return "triangleIcon"
        case .star: return "starIcon"
        }
    }
    
}
