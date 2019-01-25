//
//  NewDogCVCell.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit
var isClick = false

class NewDogCVCell: UICollectionViewCell {
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var kindImage: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        newImage.sectionRound()
    }
    @IBAction func heartClickAction(_ sender: Any) {
        if isClick == false{
            heartBtn.setImage(UIImage(named: "likedAnimalHeartBtnFill.png"), for: UIControl.State.normal)
            isClick = true
        }else{
            heartBtn.setImage(UIImage(named: "heartBtn.png"), for: UIControl.State.normal)
            isClick  = false
        }
        
        
    }
    
}
