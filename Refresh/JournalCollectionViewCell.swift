//
//  JournalCollectionViewCell.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import UIKit

class JournalCollectionViewCell: UICollectionViewCell {
    
    var journal: Journal? {
        didSet {
            dateLabel.text = journal?.dateCreated.toMonthDate().lowercased()
            moodImageView.image = UIImage(named: journal!.mood.iconString)
            feelingLabel.text = journal?.feeling
            contentView.layer.cornerRadius = 20
            contentView.clipsToBounds = true
//            contentView.outlineBorder(width: 1, color: .label)
            contentView.backgroundColor = .systemGray6
            intentionalityBackBar.layer.cornerRadius = 10
            intentionalityBackBar.clipsToBounds = true
            intentionalityFrontBar.layer.cornerRadius = 10
            intentionalityFrontBar.clipsToBounds = true
            frontBarWidth.constant = intentionalityBackBar.frame.width * CGFloat(journal!.intentionality)
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var intentionalityBackBar: UIView!
    
    @IBOutlet weak var intentionalityFrontBar: UIView!
    
    @IBOutlet weak var frontBarWidth: NSLayoutConstraint!
}
