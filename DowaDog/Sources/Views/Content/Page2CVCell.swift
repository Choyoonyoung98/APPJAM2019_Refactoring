//
//  Page2CVCell.swift
//  DowaDog
//
//  Created by 조윤영 on 02/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class Page2CVCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var bigTitle: UITextView!
    @IBOutlet weak var littleTitle: UILabel!
    
    @IBOutlet weak var readCheck: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        
        self.backView.roundRadius()
        self.cardImage.sectionBottomRound()
        
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        bigTitle.isEditable = false
    }
    
}
