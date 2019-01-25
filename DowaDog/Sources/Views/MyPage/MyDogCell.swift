//
//  MyDogCell.swift
//  DowaDog
//
//  Created by 조윤영 on 04/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MyDogCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var kindImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardImage.roundRadius()
    }
}

