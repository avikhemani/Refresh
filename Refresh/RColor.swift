//
//  RColor.swift
//  Refresh
//
//  Created by Avi Khemani on 2/22/21.
//

import Foundation
import UIKit

enum RColor: String, Codable, CaseIterable {
    
    case green
    case blue
    case orange
    case red
    case purple
    
    case pYellow
    case pBlue
    case pPurple
    case pBlue2
    case pPink
    case pPink2
    
    var string: String {
        switch self {
        case .green: return "Green"
        case .blue: return "Blue"
        case .orange: return "Orange"
        case .red: return "Red"
        case .purple: return "Purple"
        case .pYellow: return "pYellow"
        case .pBlue: return "pBlue"
        case .pPurple: return "pPurple"
        case .pBlue2: return "pBlue2"
        case .pPink: return "pPink"
        case .pPink2: return "pPink2"
        }
    }
    
    var color: UIColor {
        switch self {
        case .green: return #colorLiteral(red: 0.3647058824, green: 0.7921568627, blue: 0.6, alpha: 1)
        case .blue: return #colorLiteral(red: 0.2117647059, green: 0.431372549, blue: 0.8470588235, alpha: 1)
        case .orange: return #colorLiteral(red: 1, green: 0.6431372549, blue: 0.1058823529, alpha: 1)
        case .red: return #colorLiteral(red: 1, green: 0.337254902, blue: 0.337254902, alpha: 1)
        case .purple: return #colorLiteral(red: 0.4980392157, green: 0.4705882353, blue: 0.8235294118, alpha: 1)
        case .pYellow: return #colorLiteral(red: 1, green: 0.8274509804, blue: 0.2588235294, alpha: 1)
        case .pBlue: return #colorLiteral(red: 0, green: 0.6901960784, blue: 0.9882352941, alpha: 1)
        case .pPurple: return #colorLiteral(red: 0.3215686275, green: 0, blue: 1, alpha: 1)
        case .pBlue2: return #colorLiteral(red: 0.3647058824, green: 0.8274509804, blue: 0.8274509804, alpha: 1)
        case .pPink: return #colorLiteral(red: 1, green: 0.4392156863, blue: 0.7411764706, alpha: 1)
        case .pPink2: return #colorLiteral(red: 0.9960784314, green: 0.2039215686, blue: 0.431372549, alpha: 1)
        }
    }
    
    init(str: String) {
        switch str {
        case "Green": self = .green
        case "Blue": self = .blue
        case "Orange": self = .orange
        case "Red": self = .red
        case "Purple": self = .purple
        case "pYellow": self = .pYellow
        case "pBlue": self = .pBlue
        case "pPurple": self = .pPurple
        case "pBlue2": self = .pBlue2
        case "pPink": self = .pPink
        case "pPink2": self = .pPink2
        default: self = .green
        }
    }
    
    init(color: UIColor) {
        switch color {
        case #colorLiteral(red: 0.3647058824, green: 0.7921568627, blue: 0.6, alpha: 1): self = .green
        case #colorLiteral(red: 0.2117647059, green: 0.431372549, blue: 0.8470588235, alpha: 1): self = .blue
        case #colorLiteral(red: 1, green: 0.6431372549, blue: 0.1058823529, alpha: 1): self = .orange
        case #colorLiteral(red: 1, green: 0.337254902, blue: 0.337254902, alpha: 1): self = .red
        case #colorLiteral(red: 0.4980392157, green: 0.4705882353, blue: 0.8235294118, alpha: 1): self = .purple
        case #colorLiteral(red: 1, green: 0.8274509804, blue: 0.2588235294, alpha: 1): self = .pYellow
        case #colorLiteral(red: 0, green: 0.6901960784, blue: 0.9882352941, alpha: 1): self = .pBlue
        case #colorLiteral(red: 0.3215686275, green: 0, blue: 1, alpha: 1): self = .pPurple
        case #colorLiteral(red: 0.3647058824, green: 0.8274509804, blue: 0.8274509804, alpha: 1): self = .pBlue2
        case #colorLiteral(red: 1, green: 0.4392156863, blue: 0.7411764706, alpha: 1): self = .pPink
        case #colorLiteral(red: 0.9960784314, green: 0.2039215686, blue: 0.431372549, alpha: 1): self = .pPink2
        default: self = .green
        }
    }
    
}
