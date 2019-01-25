//
//  MyWantDogVC.swift
//  DowaDog
//
//  Created by 조윤영 on 05/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit


class MyWantDogVC: UIViewController {
    
    var myLikeList = [MyLikeList]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var reuseIdentifier = "wantCell"
    
    var pagelimit:Int?
    var lastPage:Int?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.title = "관심 동물"
        
        self.setBackBtn()
        self.setNavigationBarShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
    }
    
    
    
    func getData(){
    
        MyLikeListService.shared.getMyLikeList() { [weak self]
            
            (data) in
            
            guard let `self` = self else {return}
            
            self.myLikeList = data
            self.pagelimit = (data.count/10) + 1
            
            self.collectionView.reloadData()

            
            
            print("data ===================")
            print(data)
            print("data ===================")
        }
    }
    
}

extension MyWantDogVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myLikeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyWantCVCell
        
        
        
       let likeDog = myLikeList[indexPath.row]
        
        cell.animalImage.imageFromUrl(self.gsno((likeDog.thumbnailImg)), defaultImgPath: "")
        
        cell.heartBtn.setImage(UIImage(named:"likedAnimalHeartBtnFill.png"), for: .selected)
        
        if likeDog.type == "dog"{
            cell.kindImage.image = UIImage(named: "dogIcon1227.png")
        }else{
              cell.kindImage.image = UIImage(named: "catIcon1227.png")
        }
        
        if likeDog.sexCd == "M"{
            cell.genderImage.image = UIImage(named:"womanIcon1227")
        }else{
               cell.genderImage.image = UIImage(named:"womanIcon1227")
        }
        
        let  id = gino( likeDog.id)
        
        
        //남은 날짜 d-day 계산 부분
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "dd"
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        let getDate = self.gsno(likeDog.noticeEddt)//마감날짜
        var strArray: Array<String> = []
        strArray =  getDate.components(separatedBy:"-")
        
        let endDate  = strArray[2]
        
        let cal = Calendar.current
        let date = Date()
        let currentDate = cal.component(.day, from: date)
        
        
        //
        let dday = Int(endDate) ?? Int() - Int(currentDate)
        let Dday = "D-\(dday)"
        cell.dayLabel.text = Dday
        
        cell.heartBtn.setImage(UIImage(named:"likedAnimalHeartBtnFill.png"), for: .normal)
        cell.heartBtn.setImage(UIImage(named: "heartBtn"), for: .selected)
        
        
       
        return cell
    }
    
}

extension MyWantDogVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !(indexPath.row + 1 < self.myLikeList.count) {
            if lastPage ?? 10 <=  pagelimit ?? 100{
               getData()
            }else{
                
            }
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        let cell = self.collectionView.cellForItem(at: indexPath) as!MyWantCVCell
        
        let myDog = myLikeList[indexPath.row]

        let dvc = UIStoryboard(name: "Finding", bundle: nil).instantiateViewController(withIdentifier: "AboutEmergenVC") as! AboutEmergenVC
            
            dvc.id = gino(myDog.id)
            
            //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
            navigationController?.pushViewController(dvc, animated: true)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
    }
}

extension MyWantDogVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 45) / 2
        let height: CGFloat = ((view.frame.width - 45) / 2) * 0.8 + 53
        return CGSize(width: width, height: height)
    }
    
    
}
