//
//  ContentCell.swift
//  DowaDog
//
//  Created by 조윤영 on 10/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var contentImage: UIImageView!

    
    @IBOutlet weak var aboutTextView: UILabel!
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        aboutTextView.numberOfLines = 0

       
    }
}


