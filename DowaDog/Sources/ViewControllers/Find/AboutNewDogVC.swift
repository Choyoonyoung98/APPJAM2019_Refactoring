//
//  AboutNewDogVC.swift
//  DowaDog
//
//  Created by 조윤영 on 31/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit




class AboutNewDogVC: UIViewController {
    var heartClick = false
    
    var id:Int!
    
    @IBOutlet weak var adoptBtn: UIButton!
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var coverView: UIView!
    
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var processState: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var noticeTerm: UILabel!
    @IBOutlet weak var type: UIImageView!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UIImageView!
    @IBOutlet weak var protectPlace: UILabel!
    @IBOutlet weak var regionKind: UILabel!
    @IBOutlet weak var phoneNumb: UIButton!
    @IBOutlet weak var findPlace: UILabel!
    
    
    var heartItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        self.setNavigationBar()
        
        self.coverView.alpha = 0.0
        self.popupView.alpha = 0.0
        
        heartItem = UIBarButtonItem(image:UIImage(named: "heartBtnLine.png") , style: .plain, target: self, action: #selector(heartTapped))
        heartItem.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItems = [heartItem]
        
        
        let panGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_ :)))
        
        self.view.addGestureRecognizer(panGestureRecongnizer)
        panGestureRecongnizer.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AnimalDetailService.shared.getAnimalDetail(animalIdx: id) {
            (data) in
            
            print("data ==========================")
            print("data : ")
            print(data)
            print("data ==========================")

        }
    }
    
    
    @objc func heartTapped(){
        
        AnimalDetailService.shared.animalLike(animalIdx: id) {
            (data) in
            
            print("data ==========================")
            print("data : ")
            print(data)
            print("data ==========================")
            
        }
 
        
        if heartClick == false{
            heartItem.image = UIImage(named: "heartBtnFill")
            heartClick = true
            UIView.animate(withDuration: 0.5, animations: {
                self.coverView.alpha = 0.5
                self.popupView.alpha = 1.0
                
            })
            
            
        }else{
            heartItem.image = UIImage(named: "heartBtnLine.png")
            heartClick = false
        }
        
    }
    
    
    @objc func panAction (_ sender : UIPanGestureRecognizer){
        
        let velocity = sender.velocity(in: scroll)
        
        if abs(velocity.x) > abs(velocity.y) {

            
        }
            
        else if abs(velocity.y) > abs(velocity.x) {
            if velocity.y<0{
                
                
                self.adoptBtn.frame.size.height = 0.0
                self.adoptBtn.setTitle("", for: UIControl.State.normal)
                
            }else{
                
                self.adoptBtn.frame.size.height = 49.0
                self.adoptBtn.setTitle("임보/입양하기", for: UIControl.State.normal)
                
            }
            
            
        }
        
//        let offsetY = scroll.contentOffset.y
//        if ( offsetY > 170) {
//            UIView.animate(withDuration: 0.4, animations: {
//                self.navBarBackgroundAlpha = 1//navbar 투명하게 setup
//                
//                self.heartItem.tintColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
//                
//            })
//            
//        }else if (offsetY <= 170 ){
//            UIView.animate(withDuration: 0.4, animations: {
//                self.navBarBackgroundAlpha = 0//navbar 투명하게 setup
//                self.heartItem.tintColor = UIColor.white
//            })
//            
//        }
        
    }
    @IBAction func okBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.coverView.alpha = 0.0
            self.popupView.alpha = 0.0
            
        })
    }
    
    @IBAction func callAction(_ sender: Any) {
        
        guard let number = URL(string: "tel://" + "01056472489") else { return }
        UIApplication.shared.open(number)
        
        //이거 실제 디바이스에서는 되는지 승언 오빠 핸드폰으로 확인하기
        //데이터 받아올 때 -나 스페이스 제외해서 넣기
    }

}
extension AboutNewDogVC : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        
        return true
        
    }
    
}
