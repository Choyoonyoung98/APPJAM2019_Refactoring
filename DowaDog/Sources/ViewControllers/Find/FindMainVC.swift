//
//  FindMainVC.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class FindMainVC: UIViewController, sendBackDelegate {
    @IBOutlet weak var collectionView: UICollectionView!

    
    var getType:String = ""
    var getRegion:String = ""
    var getRemainNoticeDate:Int?
    var searchWord:String = ""
    var page:Int = 0
    var limit:Int = 10
    
    @IBOutlet var blackscreen2: UIView!
    var heartId:Int?
    
    var lastPage = 0
    var pagelimit:Int?
    
    var emergenDogList = [EmergenDog]()
    var newDogList = [EmergenDog]()
    
    @IBOutlet weak var filterBtn: UIButton!
    
    var  reusablecell = "cell1"
    var   reusablecell2 = "cell2"
    var resusableheader = "header"
    
    
    @IBOutlet var sideMenuView: UIView!
    

    
    func setNabBtn(){
        
        let searchBTN = UIBarButtonItem(image: UIImage(named: "searchIcon"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(self.searchClickAction(_:)))
        
        navigationItem.rightBarButtonItem = searchBTN
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.4548649788, green: 0.4549226761, blue: 0.4548452497, alpha: 1)
    
    }
    
    func getEmergenData(){
        EmergenDogService.shared.getEmergenDogList( page: 0, limit: 2) { [weak self]
            (data) in
            guard let `self` = self else {return}
            
            self.emergenDogList = data
            
            self.collectionView?.reloadData()
        }
    }
    
    func getData(){

        EmergenDogService.shared.findAnimalList(type: getType, region: getRegion, remainNoticeDate: 15, searchWord: "", page: lastPage, limit:10){ [weak self]
            (data) in
            guard let `self` = self else {return}
            
            print("test===")
            print(self.getType)
            print(self.getRegion)
            print(self.getRemainNoticeDate)
            print("test===")
            

            self.newDogList  = self.newDogList + data
            self.pagelimit = (data.count/10) + 1
            self.collectionView?.reloadData()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        filterBtn.roundRadius()
        
        
        setBlackScreen2()
        setSideMenu()
        setNabBtn()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        getEmergenData()
        getData()
    }
    
    
    @IBAction func storyAction(_ sender: Any) {
        
    }
    
    
    @IBAction func searchClickAction(_ sender: Any) {
        
        let filter = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchVC")
        
        //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
        navigationController?.pushViewController(filter, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "action_show"{
            
            let newFilterVC = segue.destination as! NewFilterVC
            newFilterVC.delegate = self
        }
    }
    
    func dataReceived(type: String, region: String, remainNoticeDate: Int){
        getType = type
        getRegion = region
        getRemainNoticeDate = remainNoticeDate
        
        
        print(type)
        print(region)
        print(remainNoticeDate)
        print(getType)
        print(getRegion)
        print(gino(getRemainNoticeDate))
        
        EmergenDogService.shared.findAnimalList(type: getType, region: getRegion, remainNoticeDate: getRemainNoticeDate, searchWord: "", page: 0, limit:10){ [weak self]
            (data) in
            guard let `self` = self else {return}
            
            self.newDogList = data
            self.collectionView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setBlackScreen2() {
        let tapGestRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(blackScreen2TapAction(sender:)))
        blackscreen2.addGestureRecognizer(tapGestRecognizer2)
    }
    
    @objc func blackScreen2TapAction(sender: UITapGestureRecognizer) {
        hideMenu()
    }
    
    
    
    func setSideMenu() {
        self.sideMenuView.transform = CGAffineTransform(translationX: -self.sideMenuView.frame.width, y: 0)
    }
    
    @IBAction func menuTapped(_ sender: Any) {
//        if blackFlag != true {
//            showMenu()
//        }
    }
    
    func showMenu() {
        self.navigationController?.navigationBar.layer.zPosition = -1
        
        UIView.animate(withDuration: 0.4, animations: {
            self.blackscreen2.alpha = 1
        })
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.sideMenuView.transform = .identity
        })
    }
    func hideMenu() {
        self.navigationController?.navigationBar.layer.zPosition = 1
        
        UIView.animate(withDuration: 0.4, animations: {
            self.blackscreen2.alpha = 0
        })
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.sideMenuView.transform = CGAffineTransform(translationX: -self.sideMenuView.frame.width, y: 0)
        })
    }
    
    
    @IBAction func barBtnAction(_ sender: Any) {
        showMenu()
    }
    
    
    // 연결필요
    @IBAction func sideNavBtnAction(_ sender: UIButton) {
        
        if let btnTitle = sender.titleLabel?.text {
            switch (btnTitle) {
            case "홈":
                hideMenu()
                
                performSegue(withIdentifier: "unwindToHome", sender: self)
                
                break
            case "기다릴개 란?":
                hideMenu()
                
                let info = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "InfoNav") as! UINavigationController
                
                self.present(info, animated: true, completion: nil)
                
                break
            case "입양하기":
                hideMenu()
                
                break
            case "커뮤니티":
                hideMenu()
                
                let community = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityNav") as! UINavigationController
                
                self.present(community, animated: true, completion: nil)
                
                break
            case "컨텐츠":
                hideMenu()
                
                let contents = UIStoryboard(name: "Contents", bundle: nil).instantiateViewController(withIdentifier: "ContentsNav") as! UINavigationController
                
                self.present(contents, animated: true, completion: nil)
                break
            case "마이페이지":
                hideMenu()
                if UserDefaults.standard.string(forKey: "Token") != nil {
                    let myPage = UIStoryboard(name: "MyProfile", bundle: nil).instantiateViewController(withIdentifier: "MyPageMainVC") as! MyPageMainVC
                    
                    self.navigationController?.pushViewController(myPage, animated: true)
                } else {
                    simpleAlert(title: "접근불가", message: "로그인이 필요합니다.")
                }
                break
            case "기다릴개와 함께할개":
                hideMenu()
                
                let support = UIStoryboard(name: "Support", bundle: nil).instantiateViewController(withIdentifier: "SupportNav") as! UINavigationController
                
                self.present(support, animated: true, completion: nil)
                break
            default:
                hideMenu()
                break
            }
        }
    }
}


extension FindMainVC:UICollectionViewDataSource{
    
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
        
        var returnValue = Int()
        
        if section == 0{
            
            returnValue = 0
            
        }
        else if section == 1 {
            returnValue = emergenDogList.count
        }
        else if section == 2 {
            returnValue =  newDogList.count
        }
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusablecell, for: indexPath) as! EmergenCVCell
        
        
        
        let section = indexPath.section
        
        
        
        if section == 0{
            return UICollectionViewCell()
            
        } else if section == 1 {


            let emergenDog = emergenDogList[indexPath.row]
            //데이터 집어넣기 여기서
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            
            let getDate = gsno(emergenDog.noticeEddt)//마감날짜
            
            var strArray: Array<String> = []
            strArray =  getDate.components(separatedBy:"-")
            
            let endDate  = strArray[2]
            
            let cal = Calendar.current
            let date = Date()
            let currentDate = cal.component(.day, from: date)
            
            
            
            let dday = Int(endDate) ?? Int() - Int(currentDate)
            let Dday = setDday(start: getDate)
//            let Dday = "D-\(dday)"
            //현재 날짜(currentData)가 분명 int값인데 계산에 먹히지를 않음
            
            //하단에 들어가는 해당 동물 지역과 종
            let region = gsno(emergenDog.region)
            let kind = gsno(emergenDog.kindCd)
            
            cell.emerImage.imageFromUrl(gsno( emergenDog.thumbnailImg ), defaultImgPath: "")
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
                cell.genderImage.image = UIImage(named: "womanIcon1227")
            }
            else if emergenDog.sexCd == "M" {
                cell.genderImage.image = UIImage(named: "manIcon1227")
                
            }else{
                cell.genderImage.image = UIImage(named: "디폴트이미지받을것임")
            }
            
            
            //하트 클릭여부 판단
            cell.heartBtn.setImage(UIImage(named: "findingHeartBtnFill.png"), for: .selected)
            
            cell.heartBtn.setImage(UIImage(named:"heartBtn"), for: .normal)
            
            if emergenDog.liked == false{
                
                cell.heartBtn.isSelected = false
                
            }else if emergenDog.liked == true{
                
                cell.heartBtn.isSelected = true
                
            }
            
            
        } else if section == 2 {

            let newDog = newDogList[indexPath.item]
            ////
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            
            let getDate = gsno(newDog.noticeEddt)//마감날짜
            var strArray: Array<String> = []
            strArray =  getDate.components(separatedBy:"-")
            
            let endDate  = strArray[2]
            
            let cal = Calendar.current
            let date = Date()
            let currentDate = cal.component(.day, from: date)
            
            
            
            let dday = Int(endDate) ?? Int() - Int(currentDate)
            let Dday = "D-\(dday)"
            //현재 날짜(currentData)가 분명 int값인데 계산에 먹히지를 않음
            
            //하단에 들어가는 해당 동물 지역과 종
            let region = gsno(newDog.region)
            let kind = gsno(newDog.kindCd)
            
            cell.emerImage.imageFromUrl(gsno(newDog.thumbnailImg), defaultImgPath: "")
            cell.aboutLabel.text = "[\(region)]\(kind)"
            
            cell.dayLabel.text = Dday
            
            //강아지인지 고양이인지 판단
            if newDog.type == "개"{
                cell.kindImage.image = UIImage(named: "dogIcon1227")
            }else if newDog.type == "고양이" {
                cell.kindImage.image = UIImage(named: "catIcon1227")
            }
            //암컷 수컷 판단
            if newDog.sexCd == "F" {
                cell.genderImage.image = UIImage(named: "womanIcon1227")
                
            }
            else if newDog.sexCd == "M" {
                cell.genderImage.image = UIImage(named: "manIcon1227")
                
            }else{
                cell.genderImage.image = UIImage(named: "디폴트이미지받을것임")
            }
            
            
            //하트 클릭여부 판단
            cell.heartBtn.setImage(UIImage(named: "findingHeartBtnFill"), for: .selected)
            cell.heartBtn.setImage(UIImage(named:"heartBtn"), for: .normal)
            
            if gbno(newDog.liked) == false{
                cell.heartBtn.isSelected = false
                
            }else if gbno(newDog.liked) == true{
                cell.heartBtn.isSelected = true
            }
            
        }
        return cell
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = indexPath.section
        
        if section == 0 {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as! ImageCRView
            return view

        }else if section == 1 {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: resusableheader,
                                                                       for: indexPath) as! HeaderCRView
            
            view.headerLabel.isHidden = false
            view.headerLabel.text = "긴급"
            view.nextBtn.setTitle("더보기", for: .normal)
            view.nextBtn.tintColor = UIColor.init(displayP3Red: 112/255, green: 112/255, blue: 112.255, alpha: 1)
            view.nextBtn.isHidden = false
            
            return view
            
            
        }else {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: resusableheader,
                                                                       for: indexPath) as! HeaderCRView
            
            view.headerLabel.text = "새로 구조된 아이들"
            
            view.nextBtn.isHidden = true
            return view
            
        }
    }
    
}










extension FindMainVC: UICollectionViewDelegate{

    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        if !(indexPath.row + 1 < self.newDogList.count) {
            if lastPage <=  pagelimit ?? 100{
                print("ppp")
                
                  getData()

            }else{

            }

        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        let section = indexPath.section
        
        if section == 1{
            
            let cell = self.collectionView.cellForItem(at: indexPath) as!EmergenCVCell
            
            let emergenDog = emergenDogList[indexPath.row]
            
            if let dvc = storyboard?.instantiateViewController(withIdentifier: "AboutEmergenVC") as? AboutEmergenVC {
                
                dvc.id = gino(emergenDog.id)

                //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
                navigationController?.pushViewController(dvc, animated: true)
                
            }
        }else if section == 2{
            
            let cell = self.collectionView.cellForItem(at: indexPath) as! EmergenCVCell
            
            let newDog = newDogList[indexPath.item]
            
            if let dvc = storyboard?.instantiateViewController(withIdentifier: "AboutEmergenVC") as?AboutEmergenVC {
                
                dvc.id = gino(newDog.id)
                //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
                navigationController?.pushViewController(dvc, animated: true)
                
            }
            
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            
        }
    }
    
}


extension FindMainVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 45) / 2
        let height: CGFloat = ((view.frame.width - 45) / 2) * 0.8 + 53
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 0)
        } else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 246)
        } else {
            return CGSize(width: view.frame.width, height: 0)
        }
    }
}
