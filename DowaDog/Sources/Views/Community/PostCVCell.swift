//
//  PostCVCell.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class PostCVCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var uploadDate: UILabel!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var baseView: UIView!
    
    
    override func awakeFromNib() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }

 
}
