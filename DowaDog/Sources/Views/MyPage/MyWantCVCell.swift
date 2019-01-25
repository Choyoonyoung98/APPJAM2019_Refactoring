//
//  MyWantCVCell.swift
//  DowaDog
//
//  Created by 조윤영 on 05/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MyWantCVCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    
    @IBOutlet weak var kindImage: UIImageView!
    
    @IBOutlet weak var genderImage: UIImageView!
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.roundRadius()
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        dayView.roundRadius()
        
    }
    
    
}
