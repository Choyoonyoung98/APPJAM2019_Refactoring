//
//  EmergencyCVCell.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class EmergenCVCell: UICollectionViewCell {
    var isClick = false
    
  
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var emerImage: UIImageView!
    
    @IBOutlet weak var heartBtn: UIButton!
    

    @IBOutlet weak var kindImage: UIImageView!
    
    @IBOutlet weak var genderImage: UIImageView!
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var dayView: UIView!
    

    @IBAction func heartClickAction(_ sender: UIButton) {


    }
    
    override func awakeFromNib() {
        super .awakeFromNib()
        cellBackgroundView.roundRadius()
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false

        dayView.roundRadius()
        
    }
    

}


