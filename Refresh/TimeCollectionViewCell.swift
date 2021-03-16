//
//  TimeCollectionViewCell.swift
//  Refresh
//
//  Created by Avi Khemani on 3/15/21.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    var time: Date? {
        didSet {
            timeLabel.text = time!.toHourString()
        }
    }
    
    var index: Int? {
        didSet {
            deleteButton.index = index
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deleteButton: InfoButton!
    
}
