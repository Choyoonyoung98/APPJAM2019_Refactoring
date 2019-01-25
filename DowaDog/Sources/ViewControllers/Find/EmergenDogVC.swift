//
//  EmergenDogVC.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

//MARK: refresh 못함

class EmergenDogVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var emergenDogList = [EmergenDog]()
    
    
    
    @IBOutlet weak var navbar: UINavigationItem!
    var reuseIdentifier = "emergenCell"
    
    var lastPage = 0
    var pagelimit:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackBtn()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        navbar.title = "긴급동물"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBoard()
    }
    
    func getBoard() {
        EmergenDogService.shared.getEmergenDogList(page: lastPage, limit: 10) { [weak self]
            (data) in
            guard let `self` = self else {return}
            print("---여기--------------")
            print(data)
            print("---여기--------------")
            self.emergenDogList  = self.emergenDogList + data
            self.pagelimit = (data.count/10) + 1
            self.collectionView.reloadData()
            
            self.lastPage += 1
        }
    }
}



extension EmergenDogVC:UICollectionViewDataSource{
    
    //잠깐
    //100일 남음
    func setDday(start: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let day = dateFormatter.date(from: start)! //문자열을 date포맷으로 변경
        let interval = NSDate().timeIntervalSince(day)
        let days = Int(interval / 86400)
        
        if days < 0 {
            return "\(days.magnitude)일 남음"
        } else {
            return "마감"
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return emergenDogList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmergenDetailCVCell
        
        let emergenDog = emergenDogList[indexPath.row]
        
        //남은 날짜 d-day 계산 부분
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "dd"
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        let getDate = gsno(emergenDog.noticeEddt)//마감날짜
        var strArray: Array<String> = []
        strArray =  getDate.components(separatedBy:"-")
        
        let endDate  = strArray[2]
        
        let cal = Calendar.current
        let date = Date()
        let currentDate = cal.component(.day, from: date)
        
        
        //
        let dday = Int(endDate) ?? Int() - Int(currentDate)
        let Dday = setDday(start: getDate)
//        let Dday = "D-\(dday)"
        //현재 날짜(currentData)가 분명 int값인데 계산에 먹히지를 않음
        
        //하단에 들어가는 해당 동물 지역과 종
        let region = gsno(emergenDog.region)
        let kind = gsno(emergenDog.kindCd)
        
        cell.animalImage.imageFromUrl(self.gsno(emergenDog.thumbnailImg)   , defaultImgPath: "")
        cell.aboutLabel.text = "[\(region)]\(kind)"
        
        cell.dayLabel.text = Dday
        
        //강아지인지 고양이인지 판단
        if emergenDog.type == "개"{
            cell.kindImage.image = UIImage(named: "dogIcon1227")
        }else if emergenDog.type == "고양이" {
            cell.kindImage.image = UIImage(named: "catIcon1227")
        }
        //암컷 수컷 판단
        if emergenDog.sexCd == "F" {
            cell.sexImage.image = UIImage(named: "womanIcon1227")
        }
        else if emergenDog.sexCd == "M" {
            cell.sexImage.image = UIImage(named: "manIcon1227")
        }
        
        
        //하트 클릭여부 판단
        cell.heartBtn.setImage(UIImage(named: "findingHeartBtnFill.png"), for: .selected)
        cell.heartBtn.setImage(UIImage(named:"heartBtn"), for: .normal)
        if emergenDog.liked == false{
            
            cell.heartBtn.isSelected = true
            
        }else if emergenDog.liked == true{
            
            cell.heartBtn.isSelected = false
            
        }
        
        
        
        func buttonClicked(_ sender: UIButton) {
            //Here sender.tag will give you the tapped Button index from the cell
            //You can identify the button from the tag
        }
        
        return cell
    }
    
}

extension EmergenDogVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !(indexPath.row + 1 < self.emergenDogList.count) {
            if lastPage <=  pagelimit ?? 100{
                getBoard()
            }else{
                
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = self.collectionView.cellForItem(at: indexPath) as!EmergenDetailCVCell
        
        let emergenDog = emergenDogList[indexPath.row]
        
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "AboutEmergenVC") as? AboutEmergenVC {
            
            dvc.id = gino(emergenDog.id)
            
            //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
            navigationController?.pushViewController(dvc, animated: true)
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        
    }
}


extension EmergenDogVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 45) / 2
        let height: CGFloat = ((view.frame.width - 45) / 2) * 0.8 + 53
        return CGSize(width: width, height: height)
    }
    
    
}
