//
//  ShapeCollectionViewCell.swift
//  Refresh
//
//  Created by Avi Khemani on 2/22/21.
//

import UIKit

class ShapeCollectionViewCell: UICollectionViewCell {
    
    var shape: Shape? {
        didSet {
            contentView.layer.cornerRadius = 15
            contentView.clipsToBounds = true
            shapeImageView.image = UIImage(named: shape?.iconString ?? "")
        }
    }
    
    @IBOutlet weak var shapeImageView: UIImageView!
    
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
