//
//  ColorCollectionViewCell.swift
//  Refresh
//
//  Created by Avi Khemani on 2/22/21.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    var rcolor: RColor? {
        didSet {
            contentView.backgroundColor = rcolor?.color
            contentView.layer.cornerRadius = 30
            contentView.clipsToBounds = true
        }
    }
    
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

extension UIView {
    func outlineBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color.cgColor
    }
}
