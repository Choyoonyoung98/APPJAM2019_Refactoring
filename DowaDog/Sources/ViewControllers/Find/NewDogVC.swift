//
//  NewDogVC.swift
//  DowaDog
//
//  Created by 조윤영 on 31/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class NewDogVC: UIViewController {
    
    var storyDogList = [EmergenDog]()
    
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var lastPage = 0
    var pagelimit:Int?
    
    var reuseIdentifier = "newdogCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navbar.title = "제 이야기를 들어보실래요?"
        
        self.setBackBtn()
        
        // init
        
    }
    
    func getData(){
        EmergenDogService.shared.findAnimalList(type: "", region: "", remainNoticeDate: 300, story: true, searchWord: "", page: lastPage, limit: 10) {
            (data) in
            
            print("---여기--------------")
            print(data)
            print("---여기--------------")
            
            self.storyDogList  = self.storyDogList + data
             self.pagelimit = (data.count/10) + 1
            self.lastPage += 1
            
            self.collectionView.reloadData()

            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getData()
        
    }
    
}

extension NewDogVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return storyDogList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewDogDetailCVCell
        
        let storyDog = storyDogList[indexPath.item]
        
        
        cell.animalImage.imageFromUrl(gsno(storyDog.thumbnailImg), defaultImgPath: "")
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        let getDate = gsno(storyDog.noticeEddt)//마감날짜
        var strArray: Array<String> = []
        strArray =  getDate.components(separatedBy:"-")
        
        let endDate  = strArray[2]
        
        let cal = Calendar.current
        let date = Date()
        let currentDate = cal.component(.day, from: date)
        
        
        //
        let dday = Int(endDate) ?? Int() - Int(currentDate)
        let Dday = "D-\(dday)"
        //현재 날짜(currentData)가 분명 int값인데 계산에 먹히지를 않음
        
        //하단에 들어가는 해당 동물 지역과 종
        let region = gsno(storyDog.region)
        let kind = gsno(storyDog.kindCd)
        
        cell.animalImage.imageFromUrl(self.gsno(storyDog.thumbnailImg)   , defaultImgPath: "")
        cell.aboutLabel.text = "[\(region)]\(kind)"
        
        cell.dayLabel.text = Dday
        
        //강아지인지 고양이인지 판단
        if storyDog.type == "개"{
            cell.kindImage.image = UIImage(named: "dogIcon1227")
        }else if storyDog.type == "고양이" {
            cell.kindImage.image = UIImage(named: "catIcon1227")
        }
        //암컷 수컷 판단
        if storyDog.sexCd == "F" {
            cell.genderImage.image = UIImage(named: "womanIcon1227")
        }
        else if storyDog.sexCd == "M" {
            cell.genderImage.image = UIImage(named: "manIcon1227")
        }
        
        
        //하트 클릭여부 판단
        cell.heartBtn.setImage(UIImage(named: "findingHeartBtnFill.png"), for: .selected)
        cell.heartBtn.setImage(UIImage(named:"heartBtn"), for: .normal)
        if storyDog.liked == false{
            
            cell.heartBtn.isSelected = true
            
        }else if storyDog.liked == true{
            
            cell.heartBtn.isSelected = false
            
        }
        
        
        return cell
    }
    
}

extension NewDogVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !(indexPath.row + 1 < self.storyDogList.count) {
            if lastPage <=  pagelimit ?? 100{
                getData()
            }else{
                
            }
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "StoryDogVC") as?StoryDogVC {
            
            let storyDog = storyDogList[indexPath.item]
            //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
            dvc.id = storyDog.id
            navigationController?.pushViewController(dvc, animated: true)
            print("click")
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            
            
        }
    }
}


extension NewDogVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 45) / 2
        let height: CGFloat = ((view.frame.width - 45) / 2) * 0.8 + 53
        return CGSize(width: width, height: height)
    }
    
    
}
