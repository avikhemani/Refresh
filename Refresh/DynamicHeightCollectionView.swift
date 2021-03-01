//
//  DynamicHeightCollectionView.swift
//  Habitat
//
//  Created by Avi Khemani on 3/27/20.
//  Copyright © 2020 Avi Khemani. All rights reserved.
//

import UIKit

class DynamicHeightCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    

}
