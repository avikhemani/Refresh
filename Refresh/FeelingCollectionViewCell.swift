//
//  FeelingCollectionViewCell.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import UIKit

class FeelingCollectionViewCell: UICollectionViewCell {
    
    var feelingString: String? {
        didSet {
            contentView.layer.cornerRadius = 15
            contentView.clipsToBounds = true
            contentView.outlineBorder(width: 1, color: .systemGray)
            feelingLabel.text = feelingString
        }
    }
    
    @IBOutlet weak var feelingLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = RColor.pPink.color
            } else {
                contentView.backgroundColor = .clear
            }
        }
    }
    
}
