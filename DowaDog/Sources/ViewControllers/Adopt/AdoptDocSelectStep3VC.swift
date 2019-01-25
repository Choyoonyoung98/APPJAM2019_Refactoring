//
//  AdoptDocSelectStep3VC.swift
//  DowaDog
//
//  Created by wookeon on 02/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class AdoptDocSelectStep3VC: UIViewController {

    @IBOutlet var tempBtn: UIButton!
    @IBOutlet var adoptBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
    var getDogProfile:UIImage!
    var getHave:Bool!
    var getDetail:String!
    var getPhoneNumb:String?
    var getEmail:String?
    var getAddress:String?
    var getWork:String?
    var id:Int!

    
    let normalColor: UIColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    let normalTextColor: UIColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
    let selectColor: UIColor = UIColor(red: 255/255, green: 194/255, blue: 51/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarClear()
        self.setBackBtn()
        setBtn()
    }

    func setBtn() {
        tempBtn.layer.cornerRadius = tempBtn.layer.frame.size.height/2
        adoptBtn.layer.cornerRadius = adoptBtn.layer.frame.size.height/2
    }


    @IBAction func selectBtnAction(_ sender: UIButton) {

        sender.isSelected = !sender.isSelected

        sender.setTitleColor(normalTextColor, for: .normal)
        sender.setTitleColor(UIColor.white, for: .selected)

        nextBtn.backgroundColor = selectColor

        if sender == tempBtn && sender.isSelected == true {
            adoptBtn.isSelected = false
            adoptBtn.backgroundColor = normalColor
            sender.backgroundColor = selectColor
        } else if sender == tempBtn && sender.isSelected == false {
            sender.isSelected = true
        } else if sender == adoptBtn && sender.isSelected == true {
            tempBtn.isSelected = false
            tempBtn.backgroundColor = normalColor
            sender.backgroundColor = selectColor
        } else if sender == adoptBtn && sender.isSelected == false {
            sender.isSelected = true
        }
    }


    @IBAction func nextBtnAction(_ sender: UIButton) {
        if nextBtn.backgroundColor == selectColor {
            if tempBtn.isSelected == true {
                performSegue(withIdentifier: "goTemp", sender: self)
                
                let preferences = UserDefaults.standard
                
                let typeKey = "type"
                let type = "temp"
                preferences.set(type, forKey: typeKey)
                
            } else {
                performSegue(withIdentifier: "goAdopt", sender: self)
                let preferences = UserDefaults.standard
                
                let typeKey = "type"
                let type = "adopt"
                preferences.set(type, forKey: typeKey)
                }
        }
    }
}
