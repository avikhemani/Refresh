//
//  Journal.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import Foundation

class Journal: Codable, Equatable {
    
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
    
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.mood == rhs.mood && lhs.feeling == rhs.feeling && lhs.intentionality == rhs.intentionality && lhs.notes == rhs.notes && lhs.dateCreated == rhs.dateCreated
    }
    
    
}
