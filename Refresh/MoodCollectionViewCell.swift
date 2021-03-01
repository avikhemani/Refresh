//
//  MoodCollectionViewCell.swift
//  Refresh
//
//  Created by Avi Khemani on 2/28/21.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    var mood: Mood? {
        didSet {
            contentView.layer.cornerRadius = 35
            contentView.clipsToBounds = true
            moodImageView.image = UIImage(named: mood?.iconString ?? "")
        }
    }
    
    @IBOutlet weak var moodImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.outlineBorder(width: 3, color: .label)
            } else {
                contentView.outlineBorder(width: 0, color: .label)
            }
        }
    }
    
}
