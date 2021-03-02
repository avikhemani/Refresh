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
            intentionalitySlider.value = journal?.intentionality ?? 0.5
            contentView.layer.cornerRadius = 20
            contentView.clipsToBounds = true
            contentView.outlineBorder(width: 1, color: .label)
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var intentionalitySlider: UISlider!
    
}
