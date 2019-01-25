//
//  FilterCRView.swift
//  DowaDog
//
//  Created by 조윤영 on 03/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class FilterCRView: UICollectionReusableView {
    
    
    @IBOutlet weak var dogBtn: UIButton!
    
    @IBOutlet weak var catBtn: UIButton!
    
    @IBOutlet weak var slider: CustomUISlider!
    @IBOutlet weak var maxDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dogBtn.roundRadius()
        catBtn.roundRadius()
    }
    
    
    @IBAction func dogSelectedAction(_ sender: UIButton) {
        
        
        sender.setImage(UIImage(named: "filterDogIconYellow.png"), for: UIControl.State.normal)
        catBtn.setImage(UIImage(named: "filterCatIconGrey.png"), for: UIControl.State.normal)
    }
    
    @IBAction func catSelectedAction(_ sender: UIButton) {
        
        sender.setImage(UIImage(named: "filterCatIconYellow.png"), for: UIControl.State.normal)
        dogBtn.setImage(UIImage(named: "filterDogIconGrey.png"), for: UIControl.State.normal)
        
        
        
    }
    
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        maxDate.text = "\(currentValue)일"
        
        if(currentValue == 15){
            maxDate.text = "\(currentValue)일 이상"
        }
    }
    
    
}
