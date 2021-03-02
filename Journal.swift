//
//  Journal.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import Foundation

class Journal: Codable {
    
    var mood: Mood
    var feeling: String
    var intentionality: Float
    var notes: String?
    var dateCreated: Date
    
    init(mood: Mood, feeling: String, intentionality: Float, notes: String? = nil) {
        self.mood = mood
        self.feeling = feeling
        self.intentionality = intentionality
        self.notes = notes
        self.dateCreated = Date()
    }
    
    
    
}
