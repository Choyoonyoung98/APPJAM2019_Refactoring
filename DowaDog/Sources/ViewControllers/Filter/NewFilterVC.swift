//
//  NewFilterVC.swift
//  DowaDog
//
//  Created by wookeon on 10/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

protocol sendBackDelegate {
    func dataReceived(type: String, region: String, remainNoticeDate: Int)
}

class NewFilterVC: UIViewController {
    
    // delegate variables
    var type: String?
    var region: String?
    var remainNoticeDate: Int?
    var delegate: sendBackDelegate?
    
    // navigationBar Item
    var resetBtn: UIBarButtonItem!
    
    // Kind Button
    @IBOutlet var dogBtn: UIButton!
    @IBOutlet var catBtn: UIButton!
    
    // Seekbar
    @IBOutlet var seekbar: CustomUISlider!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var endDate: UILabel!
    
    // Area Button
    @IBOutlet var areaBtn1: UIButton!
    @IBOutlet var areaBtn2: UIButton!
    @IBOutlet var areaBtn3: UIButton!
    @IBOutlet var areaBtn4: UIButton!
    @IBOutlet var areaBtn5: UIButton!
    @IBOutlet var areaBtn6: UIButton!
    @IBOutlet var areaBtn7: UIButton!
    @IBOutlet var areaBtn8: UIButton!
    @IBOutlet var areaBtn9: UIButton!
    var areaBtnArray: Array<UIButton> = []
   
    // submit Button
    @IBOutlet var submitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init
        setBackBtn()
        initButton()
        setButtonImage()
        setNavigationBarBtn()
        setNavigationBarClear()
    }
    
    // set navigationBar Button
    func setNavigationBarBtn() {
        self.title = "필터"
            let bar: UINavigationBar! = self.navigationController?.navigationBar
 
        bar.barTintColor = UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0)
        resetBtn = UIBarButtonItem(image:UIImage(named: "filterRefresh") , style: .plain, target: self, action: #selector(refreshAction))
        resetBtn.tintColor = UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        navigationItem.rightBarButtonItems = [resetBtn]
    }
    
    // refresh Button Action
    @objc func refreshAction() {
        initButton()
    }
    
    // set button Image
    func setButtonImage() {
        // set kindButton Image
        dogBtn.setImage(UIImage(named: "filterDogIconGrey"), for: .normal)
        dogBtn.setImage(UIImage(named: "filterDogIconYellow"), for: .selected)
        catBtn.setImage(UIImage(named: "filterCatIconGrey"), for: .normal)
        catBtn.setImage(UIImage(named: "filterCatIconYellow"), for: .selected)
        
        // set AreaButton Image
        areaBtn1.setImage(UIImage(named: "wholeAreaBtnDefault"), for: .normal)
        areaBtn1.setImage(UIImage(named: "wholeAreaBtnYellow"), for: .selected)
        areaBtn2.setImage(UIImage(named: "seoulBtnDefault"), for: .normal)
        areaBtn2.setImage(UIImage(named: "seoulBtnYellow"), for: .selected)
        areaBtn3.setImage(UIImage(named: "gyeonggilBtnDefault"), for: .normal)
        areaBtn3.setImage(UIImage(named: "gyeonggilBtnYellow"), for: .selected)
        areaBtn4.setImage(UIImage(named: "incheonBtnDefault"), for: .normal)
        areaBtn4.setImage(UIImage(named: "incheonBtnYellow"), for: .selected)
        areaBtn5.setImage(UIImage(named: "gangwonBtnDefault"), for: .normal)
        areaBtn5.setImage(UIImage(named: "gangwonBtnYellow"), for: .selected)
        areaBtn6.setImage(UIImage(named: "chungcheongBtnDefault"), for: .normal)
        areaBtn6.setImage(UIImage(named: "chungcheongBtnYellow"), for: .selected)
        areaBtn7.setImage(UIImage(named: "jeollaBtnDefault"), for: .normal)
        areaBtn7.setImage(UIImage(named: "jeollaBtnYellow"), for: .selected)
        areaBtn8.setImage(UIImage(named: "gyeongsangBtnDefault"), for: .normal)
        areaBtn8.setImage(UIImage(named: "gyeongsangBtnYellow"), for: .selected)
        areaBtn9.setImage(UIImage(named: "jejuBtnDefault"), for: .normal)
        areaBtn9.setImage(UIImage(named: "jejuBtnYellow"), for: .selected)
    }
    
    // init Button
    func initButton() {
        areaBtnArray = [areaBtn1, areaBtn2, areaBtn3, areaBtn4, areaBtn5, areaBtn6, areaBtn7, areaBtn8, areaBtn9]
        
        dogBtn.isSelected = true
        catBtn.isSelected = false
        seekbar.value = 8
        endDate.text = "8일"
        
        for i in 0..<areaBtnArray.count {
            areaBtnArray[i].isSelected = false
        }
        areaBtnArray[0].isSelected = true
    }
    
    // kind Button Action
    @IBAction func kindBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        
        if sender == dogBtn && dogBtn.isSelected {
            if catBtn.isSelected {
                type = ""
            } else {
                type = "개"
            }
        } else if sender == dogBtn && !dogBtn.isSelected {
            if catBtn.isSelected {
                type = "고양이"
            } else {
                type = ""
            }
        }
    }
    
    // slider Action
    @IBAction func seekbarAction(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        endDate.text = "\(currentValue)일"
        remainNoticeDate = currentValue
        
        if currentValue == 15 {
            endDate.text = "\(currentValue)일 이상"
            remainNoticeDate = 300
        }
    }
    
    // area Button Action
    @IBAction func areaBtnAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = ""
            
            break
        case 1:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = "서울"
            
            break
        case 2:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = "경기"
            
            break
        case 3:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = "인천"
            
            break
        case 4:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = "강원"
            
            break
        case 5:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = "충청"
            
            break
        case 6:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = "전라"
            
            break
        case 7:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = "경상"
            
            break
        case 8:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            sender.isSelected = true
            region = "제주"
            
            break
        default:
            for i in 0..<areaBtnArray.count {
                areaBtnArray[i].isSelected = false
            }
            areaBtnArray[0].isSelected = true
            region = ""
            
            break
        }
    }
    
    // submit Button Action
    @IBAction func submitBtnAction(_ sender: Any) {
        
        delegate?.dataReceived(type: type ?? "", region: region ?? "", remainNoticeDate: remainNoticeDate ?? 8)
        
        navigationController?.popViewController(animated: true)
    }
}
