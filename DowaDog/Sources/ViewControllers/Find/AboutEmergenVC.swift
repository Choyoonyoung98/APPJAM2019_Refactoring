//
//  AboutEmergenVC.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class AboutEmergenVC: UIViewController {
    var heartClcik = false
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var notice2View: UIView!
    @IBOutlet weak var coverView: UIView!
    
    var numb : String!
    var heart: UIBarButtonItem!
    var id : Int!
    var Dday:String?
    

    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var regionKind: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var genderIcon: UIImageView!
    @IBOutlet weak var kindIcon: UIImageView!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var noticeTerm: UILabel!
    @IBOutlet weak var findPlace: UILabel!
    @IBOutlet weak var protectPlace: UILabel!
    @IBOutlet weak var phoneNumb: UIButton!
    
    @IBOutlet weak var dDay: UILabel!
    
    @IBOutlet weak var noticeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        
        heart = UIBarButtonItem(image:UIImage(named: "heartBtnLine.png") , style: .plain, target: self, action: #selector(heartTapped))
        heart.tintColor = UIColor.white
        navigationItem.rightBarButtonItems = [heart]
        
        
        coverView.alpha = 0.0
        popupView.alpha = 0.0
        alertView.alpha = 0.0
        noticeView.roundRadius()
        notice2View.roundRadius()
        
        self.setNavigationBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("transfer=========")
        
        AnimalDetailService.shared.getAnimalDetail(animalIdx: id) {
            (data) in
            
            print("data ===================")
            print(data)
            print("data ===================")

            
            if self.gbno(data.liked ) == true{
                 self.heart.image = UIImage(named: "heartBtnFill")
                self.heartClcik = true
            }else if self.gbno(data.liked) == false{
                self.heartClcik = false
                self.heart.image = UIImage(named: "heartBtnLine.png")
            }
            
            self.age.text  = "\(self.gsno(data.age))살"
            
            let region = self.gsno(data.region)
            let kind = self.gsno(data.kindCd)
            
            self.regionKind.text =  "[\(region)]\(kind)"
            self.mainImg.imageFromUrl(self.gsno(data.thumbnailImg), defaultImgPath: "")
            
            //남녀 판단
            if data.sexCd == "M" {
                
                self.gender.text = "수컷"
                self.genderIcon.image = UIImage(named: "manIcon1227")
            }else if data.sexCd == "F"{
                self.gender.text = "암컷"
                self.genderIcon.image = UIImage(named: "womanIcon1227")
            }else{
                self.gender.text = "미등록"
            
            }
            self.about.text = self.gsno(data.specialMark)
            
            //type 판단
            if data.type == "개" {
                self.kindIcon.image = UIImage(named: "dogIcon1227")
            }else if data.type == "고양이"{
                     self.kindIcon.image = UIImage(named: "catIcon1227")
                
            }
            
            self.weight.text = "\(self.gsno(data.weight))kg"

            var  start:String!
            var end:String!
            
            if data.startDate == nil{
                 start = "미등록"
            }else{
                start = data.startDate
            }
            
            if  data.endDate == nil{
                end =  "미등록"
            }else{
                end = data.endDate
            }
            
            self.noticeTerm.text =  "\(self.gsno(start))-\(self.gsno(end))"
            self.findPlace.text = self.gsno(data.happenPlace)
            self.protectPlace.text = self.gsno(data.careName)
            self.phoneNumb.setTitle(self.gsno(data.careTel), for: .normal)
            
            
        }
        print("transfer=========")
    }

    
    @objc func heartTapped(){
        
        AnimalDetailService.shared.animalLike(animalIdx: id) {
            (data) in
            
            print("data ==========================")
            print("data : ")
            print(data)
            print("data ==========================")
            
            
        }
        if heartClcik == false{
            heart.image = UIImage(named: "heartBtnFill")
            heartClcik = true
            UIView.animate(withDuration: 0.5, animations: {
                self.coverView.alpha = 0.5
                self.popupView.alpha = 1.0
                
            })
            
        }else{
            heart.image = UIImage(named: "heartBtnLine.png")
            heartClcik = false
        }
        
    }
    
    @IBAction func okBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            
            self.coverView.alpha = 0.0
            self.popupView.alpha = 0.0
            
        })
        
    }
    
    @IBAction func adoptAction(_ sender: Any) {
        
        AnimalDetailService.shared.getAnimalDetail(animalIdx: id) {
            (data) in
            if data.educationState == false{
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.coverView.alpha = 0.5
                    self.alertView.alpha = 1.0

                })
               
            }else {
                
               
                    if let adopt = UIStoryboard(name: "Adopt", bundle: nil).instantiateViewController(withIdentifier: "AdoptVC") as? AdoptVC{
                        adopt.id = self.id
                        self.navigationController?.pushViewController(adopt, animated: true)
                    }
                // Main 은 Main.storyboard, 뒤에껀 넘어갈 view 의 Storyboard identifier, as 뒤는 클래스
                
                  
            }
            
        }
    }
    @IBAction func ok2Action(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            
            self.coverView.alpha = 0.0
            self.alertView.alpha = 0.0
            
        })
    }
    
    
    @IBAction func callAction(_ sender: Any) {
        
        guard let number = URL(string: "tel://" + "01056472489") else { return }
        UIApplication.shared.open(number)
        
        //이거 실제 디바이스에서는 되는지 승언 오빠 핸드폰으로 확인하기
        //데이터 받아올 때 -나 스페이스 제외해서 넣기
        
        
    }
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}

extension UIAlertController {
    
    static func showMessage(_ message: String) {
        showAlert(title: "", message: message, actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)])
    }
    
    static func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for action in actions {
                alert.addAction(action)
            }
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController, let presenting = navigationController.topViewController {
                presenting.present(alert, animated: true, completion: nil)
            }
        }
    }
}

