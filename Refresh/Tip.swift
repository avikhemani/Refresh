//
//  Tip.swift
//  Refresh
//
//  Created by Avi Khemani on 3/10/21.
//

import Foundation

class Tip {
    
    var insight: String
    var advice: String
    var action: String
    var task: Task
    
    init(insight: String, advice: String, action: String, task: Task) {
        self.insight = insight
        self.advice = advice
        self.action = action
        self.task = task
    }
    
}
