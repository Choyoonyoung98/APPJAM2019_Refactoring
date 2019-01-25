//
//  CustomColorUICVLayoutAttributes.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class CustomColorUICVLayoutAttributes: UICollectionViewLayoutAttributes {
    var color: UIColor = UIColor.white
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let newAttributes: CustomColorUICVLayoutAttributes = super.copy() as! CustomColorUICVLayoutAttributes
        newAttributes.color = self.color.copy(  )as! UIColor
    
        return newAttributes
    }

class SCSBCollectionReusableView : UICollectionReusableView {
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let scLayoutAttributes  = layoutAttributes as! CustomColorUICVLayoutAttributes
        self.backgroundColor = scLayoutAttributes.color
    }
    
}
}
