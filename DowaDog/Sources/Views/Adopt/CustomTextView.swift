//
//  CustomTextView.swift
//  DowaDog
//
//  Created by wookeon on 01/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

@IBDesignable class CumstomTextView: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = 2
        textContainer.lineBreakMode = .byTruncatingTail
    }
}
