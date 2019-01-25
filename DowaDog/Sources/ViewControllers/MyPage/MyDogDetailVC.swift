//
//  MyDogDetailVC.swift
//  DowaDog
//
//  Created by 조윤영 on 04/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MyDogDetailVC: UIViewController {
    
    var id:Int!
    var gender:String!
    var isNeuter:Bool!
    
      var inoculationArray: Array<String> = []
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var doBtn: UIButton!
    @IBOutlet weak var undoBtn: UIButton!
    
    @IBOutlet weak var inject1Btn: UIButton!
    @IBOutlet weak var inject2Btn: UIButton!
    @IBOutlet weak var inject3Btn: UIButton!
    @IBOutlet weak var inject4Btn: UIButton!
    @IBOutlet weak var inject5Btn: UIButton!
    @IBOutlet weak var inject6Btn: UIButton!
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var kindTf: UITextField!
    @IBOutlet weak var birthTf: UITextField!
    @IBOutlet weak var weightTf: UITextField!
    
    
    var confirmItem:UIBarButtonItem!
    
    var inoculationList = [InoculationList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        maleBtn.setImage(UIImage(named:"adoptingDocumentCheckDefault"), for: .normal)
        maleBtn.setImage(UIImage(named:"adoptingDocumentCheckYellow"), for: .selected)
        
        femaleBtn.setImage(UIImage(named:"adoptingDocumentCheckDefault"), for: .normal)
        femaleBtn.setImage(UIImage(named:"adoptingDocumentCheckYellow"), for: .selected)
        
        doBtn.setImage(UIImage(named:"adoptingDocumentCheckDefault"), for: .normal)
        doBtn.setImage(UIImage(named:"adoptingDocumentCheckYellow"), for: .selected)
        
        doBtn.isSelected  = false
        undoBtn.isSelected = true
        
        
        maleBtn.isSelected = false
        femaleBtn.isSelected = true
        inject1Btn.isSelected = false
        inject2Btn.isSelected = false
        inject3Btn.isSelected = false
        inject4Btn.isSelected = false
        inject5Btn.isSelected = false
        inject6Btn.isSelected = false
        
        profileImage.circleImageView()
        
        self.title = "개인 정보 수정"
        
        confirmItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(confirmTapped))
        confirmItem.tintColor = UIColor.init(displayP3Red: 1, green: 194/255, blue: 51/255, alpha: 1)
        
        navigationItem.rightBarButtonItems = [ confirmItem ]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AnimalUserAdoptDetailService.shared.getAdoptAnimalDetail(adoptAnimalIdx: id) {
            (data) in
            
            print("data======================")
            print("data : ")
            print(data)
            print("data======================")
            
            self.nameTf.text = self.gsno(data.name)
            self.kindTf.text = self.gsno(data.kind)
            self.birthTf.text = self.gsno(data.age)
            self.weightTf.text = self.gsno(data.weight)
            
            
            if self.gsno(data.gender) == "M"{
                self.maleBtn.isSelected = true
                self.gender = "M"
                self.femaleBtn.isSelected = false
            }else if self.gsno(data.gender) == "F"{
                self.femaleBtn.isSelected = true
                self.maleBtn.isSelected = false
                self.gender = "F"
                
            }
            
            if self.gbno(data.neuterYn) == true{
                self.doBtn.isSelected = true
                self.undoBtn.isSelected = false
                self.isNeuter = true
                
            }else if self.gbno(data.neuterYn) == false{
                self.undoBtn.isSelected = true
                self.doBtn.isSelected = false
                self.isNeuter = false
            }
            
            
            
        }
        
        AnimalUserAdoptInoculationService.shared.getAdoptAnimalInoculation(adoptAnimalIdx: id) {
            
            (data) in
            
            print("data===================")
            print("data : ")
            print(data)
            print("list")
            self.inoculationList = data
            print("data===================")
            
            if self.inoculationList[0].complete == true{
                self.inject1Btn.isSelected = true
                self.inoculationArray.append("I1")
            }else{
                   self.inject1Btn.isSelected = false
            }
            
            if self.inoculationList[1].complete == true{
                self.inject2Btn.isSelected = true
                   self.inoculationArray.append("I2")
            }else{
                self.inject2Btn.isSelected = false
            }
            
            if self.inoculationList[2].complete == true{
                self.inject3Btn.isSelected = true
                  self.inoculationArray.append("I3")
            }else{
                self.inject3Btn.isSelected = false
            }
            
            if self.inoculationList[3].complete == true{
                self.inject4Btn.isSelected = true
                  self.inoculationArray.append("I4")
            }else{
                self.inject4Btn.isSelected = false
            }
            
            if self.inoculationList[4].complete == true{
                self.inject5Btn.isSelected = true
                  self.inoculationArray.append("I5")
            }else{
                self.inject5Btn.isSelected = false
            }
            
            if self.inoculationList[5].complete == true{
                self.inject6Btn.isSelected = true
                  self.inoculationArray.append("I6")
            }else{
                self.inject6Btn.isSelected = false
            }
        }
        
    }
    
  
    

   
    
    
    @objc func confirmTapped(){
        //TODO: 확인 선택 시 일어날 액션
        
        let name:String! = nameTf.text
        let kind:String! = kindTf.text
        let weight:String! = weightTf.text
        let birth:String! = birthTf.text
        let profile:UIImage! = profileImage?.image
        
        
        AnimalUserAdoptDetailService.shared.putAdoptAnimalDetail(adoptAnimalIdx: id , name: name, gender: gender, kind:kind, weight: weight, neuterYn: isNeuter, profileImgFile: profile, age: birth, inoculationArray: inoculationArray) {
            (data) in
    
            
            print("data==========confirm==========")
            print(data)
            print("data==========confirm==========")
            
        self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    @IBAction func maleAction(_ sender: Any) {
        maleBtn.isSelected = true
        femaleBtn.isSelected = false
    }
    
    @IBAction func femaleAction(_ sender: Any) {
        femaleBtn.isSelected = true
        maleBtn.isSelected = false
    }
    
    @IBAction func doAction(_ sender: Any) {
        doBtn.isSelected = true
        undoBtn.isSelected = false
    }
    
    @IBAction func undoAction(_ sender: Any) {
        doBtn.isSelected = false
        doBtn.isSelected = true
    }
    
    @IBAction func injectAction(_ sender: UIButton) {
        sender.setImage(UIImage(named:"adoptingDocumentCheckDefault"), for: .normal)
        sender.setImage(UIImage(named:"adoptingDocumentCheckYellow"), for: .selected)
        
        if sender == inject1Btn && sender.isSelected == false{
            sender.isSelected = true
        }else if sender == inject1Btn && sender.isSelected == true{
            sender.isSelected = false
        }else if sender == inject2Btn && sender.isSelected == false{
            sender.isSelected = true
        }else if sender == inject2Btn && sender.isSelected == true{
            sender.isSelected = false
        }else if sender == inject3Btn && sender.isSelected == false{
            sender.isSelected = true
        }else if sender == inject3Btn && sender.isSelected == true{
            sender.isSelected = false
        }else if sender == inject4Btn && sender.isSelected == false{
            sender.isSelected = true
        }else if sender == inject4Btn && sender.isSelected == true{
            sender.isSelected = false
        }else if sender == inject5Btn && sender.isSelected == false{
            sender.isSelected = true
        }else if sender == inject5Btn && sender.isSelected == true{
            sender.isSelected = false
        }else if sender == inject6Btn && sender.isSelected == false{
            sender.isSelected = true
        }else if sender == inject6Btn && sender.isSelected == true{
            sender.isSelected = false
        }
        
    }
    
}
