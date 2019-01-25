//
//  CheckBox.swift
//  DowaDog
//
//  Created by wookeon on 31/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    override func awakeFromNib() {
        self.setImage(UIImage(named:"adoptingDocumentCheckYellow"), for: .selected)
        self.setImage(UIImage(named:"adoptingDocumentCheckGrey"), for: .normal)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        self.isSelected = !self.isSelected
    }
}
