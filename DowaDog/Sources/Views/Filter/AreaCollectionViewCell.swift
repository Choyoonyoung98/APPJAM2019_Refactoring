//
//  AreaCollectionViewCell.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class AreaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var areaImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super .awakeFromNib()
        self.layer.cornerRadius = 10
        self.areaImage.roundRadius()
        
        
        
    }
    
    
}
