//
//  MailCell.swift
//  DowaDog
//
//  Created by 조윤영 on 04/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MailCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mailImage: UIImageView!
    @IBOutlet weak var updatedImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        subtitle.numberOfLines = 0
        title.numberOfLines = 0
          
    }
    
}
