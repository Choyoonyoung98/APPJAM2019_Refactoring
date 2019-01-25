//
//  NewDogDetailCVCell.swift
//  DowaDog
//
//  Created by 조윤영 on 31/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class NewDogDetailCVCell: UICollectionViewCell {
    
    @IBOutlet weak var dayView: UIView!
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var heartBtn: UIButton!
    
    @IBOutlet weak var kindImage: UIImageView!
    
    @IBOutlet weak var genderImage: UIImageView!
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.roundRadius()
        
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        self.heartBtn.isEnabled = false
        
        dayView.roundRadius()
        
        
    }
    @IBAction func heartClickAction(_ sender: Any) {
//        if isClick == false{
//            heartBtn.setImage(UIImage(named: "likedAnimalHeartBtnFill.png"), for: UIControl.State.normal)
//            isClick = true
//        }else{
//            heartBtn.setImage(UIImage(named: "heartBtn.png"), for: UIControl.State.normal)
//            isClick  = false
//        }
    }
}
