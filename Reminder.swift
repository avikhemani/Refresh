//
//  Reminder.swift
//  Refresh
//
//  Created by Avi Khemani on 3/15/21.
//

import Foundation

class Reminder: Codable {
    
    var identifier: String
    var time: DateComponents
    
    init(identifier: String, time: DateComponents) {
        self.identifier = identifier
        self.time = time
    }
    
}
