//
//  ReplyCell.swift
//  DowaDog
//
//  Created by 조윤영 on 12/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var idTextView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    
    @IBOutlet weak var replyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        replyTextView.isEditable = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
