//
//  StoryDogVC.swift
//  DowaDog
//
//  Created by 조윤영 on 10/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class StoryDogVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var coverView: UIView!
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var adoptBtn: UIButton!
    
    var lastPage = 0

    var age:String?
    var tel:String?
    var care:String?
    var start:String?
    var end:String?
    var dogkind:String?
    var happen:String?
    var like:Bool?
    var state:String?
    var region:String?
    var image:String?
    var type:String?
    var gender:String?
    var weight:String?
    var about:String?
    var storyArray: Array<String> = []
    
    var heartClick:Bool?
    
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var alertView: UIView!
    
    
    var viewDidLayoutSubviewsForTheFirstTime = true
    
    var id:Int!
    
    var heartItem:UIBarButtonItem!
    
    var  reusablecell = "storyCell"
    var resusableheader = "storyHeader"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        heartItem = UIBarButtonItem(image:UIImage(named: "heartBtnLine.png") , style: .plain, target: self, action: #selector(heartTapped))
        self.heartItem.tintColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        
        navigationItem.rightBarButtonItems = [heartItem]
        
        let panGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_ :)))
        
        collectionView.addGestureRecognizer(panGestureRecongnizer)
        panGestureRecongnizer.delegate = self
        
        collectionView.delaysContentTouches = true
        
        adoptBtn.alpha = 0.0
        
        popupView.alpha = 0.0
        coverView.alpha = 0.0
        
        noticeView.roundRadius()
        setNavigationSahdow()
        

    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView?.reloadData()
        
        AnimalDetailService.shared.getAnimalDetail(animalIdx: id){
            (data) in
            
            print("data ===================")
            print(data)
            print("data ===================")
            
            
            self.storyArray = self.gano(data.animalStoryList) as! Array<String>
            
            self.collectionView.reloadData()
            
            
            if data.liked == true{
                self.heartClick = true
                
            }else if data.liked == false{
                self.heartClick = false
                
            }
        }
        print("transfer=========")
        
    }
    
    @objc func panAction (_ sender : UIPanGestureRecognizer){
        
        let velocity = sender.velocity(in: collectionView)
        
        if abs(velocity.x) > abs(velocity.y) {
            
            
        }
            
        else if abs(velocity.y) > abs(velocity.x) {
            if velocity.y<0{
                self.adoptBtn.alpha = 0.0
                
            }else{
                self.adoptBtn.alpha = 1.0
                
            }
            
        }
        
//        let offsetY = collectionView.contentOffset.y
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
    
    @IBAction func likeOkBtnAction(_ sender: Any) {
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
    
    @IBAction func adoptAction(_ sender: Any) {
        
        
        AnimalDetailService.shared.getAnimalDetail(animalIdx: id) {
            (data) in
            if data.educationState == false{
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.coverView.alpha = 1.0
                    self.alertView.alpha = 1.0
                    
                })
                
            }else {
                
                if let adopt = UIStoryboard(name: "Adopt", bundle: nil).instantiateViewController(withIdentifier: "AdoptVC") as? AdoptVC{
                    adopt.id = self.id
                    self.navigationController?.pushViewController(adopt, animated: true)
                }
               
            }
            
        }
    }
    
}
extension StoryDogVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

                return  storyArray.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! StoryImageCVCell
        
                    let story = self.storyArray[indexPath.item]
                    //데이터 집어넣기 여기서
                    cell.storyImage.imageFromUrl(story, defaultImgPath: "communityNoimg")
        
                return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let view = collectionView.dequeueReusableSupplementaryView(ofKind:kind,withReuseIdentifier: resusableheader,for: indexPath) as! StoryHeader
        
        AnimalDetailService.shared.getAnimalDetail(animalIdx: id){
            (data) in
           
            view.mainImage.imageFromUrl(self.gsno(data.thumbnailImg), defaultImgPath: "communityNoimg")
            view.aboutLabel.text = self.gsno(data.specialMark)
            view.age.text = "\(self.gsno(data.age))살"
            
            let getRegion = self.gsno(data.region)
            let getKind = self.gsno(data.kindCd)
            
            view.regionKind.text = "[\(getRegion)]\(getKind)"
            
            //남녀 판단
            if data.sexCd == "M" {
                
                view.genderLabel.text = "수컷"
                view.genderIcon.image = UIImage(named: "manIcon1227")
            }else if data.sexCd  == "F"{
                view.genderLabel.text = "암컷"
                view.genderIcon.image = UIImage(named: "womanIcon1227")
            }else{
                view.genderLabel.text = "-"
                view.genderIcon.image = UIImage(named:"중성화사진")
            }
            
            //type 판단
            if data.type == "개" {
                view.typeIcon.image = UIImage(named: "dogIcon1227")
            }else if data.type  == "고양이" {
                view.typeIcon.image = UIImage(named: "catIcon1227")
            }
            view.weight.text =  "\(self.gsno(data.weight))kg"
            
            var  startText:String!
            var endText:String!
            
            if data.startDate == nil{
                startText = "-"
            }else{
                startText = data.startDate
            }
            
            if  data.endDate == nil{
                endText =  "-"
            }else{
                endText = data.endDate
            }
            
            
            view.remainTerm.text = "\(self.gsno(startText))-\(self.gsno(endText))"
            view.findPlace.text = self.gsno(data.happenPlace)
            
            if data.processState == "notice"{
                view.processState.text = "공고중"
                
            }else if data.processState == "adopt"{
                view.processState.text = "입양 완료"
                
            }else if data.processState == "step" {
                view.processState.text = "입양 진행중"
                
            }else{
                view.processState.text = "-"
            }
            
            view.protectPlace.text = data.careName
            view.phoneNumb.setTitle(data.careTel, for: .normal)
        }
        return view
        
    }
}


extension StoryDogVC: UICollectionViewDelegate{
    
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}

extension StoryDogVC : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        
        return true
        
    }
    
}


