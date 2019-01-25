//
//  ContentHeader.swift
//  DowaDog
//
//  Created by 조윤영 on 10/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class ContentHeader: UICollectionReusableView {
    @IBOutlet weak var title: UITextView!
    @IBOutlet weak var contentDate: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.isEditable = false
    }
}
