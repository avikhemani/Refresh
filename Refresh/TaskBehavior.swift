//
//  TaskBehavior.swift
//  Refresh
//
//  Created by Avi Khemani on 2/21/21.
//

import UIKit

class TaskBehavior: UIDynamicBehavior {
    
    lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        return behavior
    }()
    
    lazy var dynamicItemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 0.5
        behavior.friction = 0.0
        behavior.resistance = 0.0
        return behavior
    }()
    
    lazy var gravityBehavior: UIGravityBehavior = {
        let behavior = UIGravityBehavior()
        behavior.magnitude = 1.0
        return behavior
    }()
    
    override func willMove(to dynamicAnimator: UIDynamicAnimator?) {
        if dynamicAnimator != nil {
            addBehaviors()
        }
    }
    
    private func addBehaviors() {
        addChildBehavior(collisionBehavior)
        addChildBehavior(dynamicItemBehavior)
        addChildBehavior(gravityBehavior)
    }
    
    func addItem(item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        dynamicItemBehavior.addItem(item)
        gravityBehavior.addItem(item)
    }

}
