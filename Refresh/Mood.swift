//
//  Shape.swift
//  Refresh
//
//  Created by Avi Khemani on 2/21/21.
//

import Foundation

enum Mood: String, CaseIterable, Codable {
    
    case supersad
    case sad
    case neutral
    case happy
    case superhappy
    
    var iconString: String {
        switch self {
        case .supersad: return "supersadIcon"
        case .sad: return "sadIcon"
        case .neutral: return "neutralIcon"
        case .happy: return "happyIcon"
        case .superhappy: return "superhappyIcon"
        }
    }
    
}
