//
//  CommunityVC.swift
//  DowaDog
//
//  Created by wookeon on 29/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class CommunityVC: UIViewController {
    
    
    var communityList = [Community<CommunityImgList>]()

    @IBOutlet var communityTableView: UITableView!
    
    @IBOutlet var sideMenuView: UIView!
    
    @IBOutlet var blackscreen2: UIView!
    var blackFlag: Bool = false             //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSideMenu()
        setBlackScreen2()
    
        
        communityTableView.dataSource = self        
        communityTableView.delegate = self
    }

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        CommunityListService.shared.getCommunityList(page: 0, limit: 10) {[weak self]
            (data) in
            guard let `self` = self else {return}

            self.communityList = data
            
            
            print("data================")
            print(data)
            print("data================")

            self.communityTableView.reloadData()
        }
    }
    
    @IBAction func writeBtnAction(_ sender: UIButton) {
        
        if UserDefaults.standard.string(forKey: "Token") != nil {
            performSegue(withIdentifier: "goCommunityWriteVC", sender: self)
        } else {
            simpleAlert(title: "접근 불가", message: "로그인이 필요합니다.")
        }
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
                
                let finding = UIStoryboard(name: "Finding", bundle: nil).instantiateViewController(withIdentifier: "FindingNav") as! UINavigationController
                
                self.present(finding, animated: true, completion: nil)
                
                break
            case "커뮤니티":
                hideMenu()
                
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












































extension CommunityVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return communityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let oneTVC = communityTableView.dequeueReusableCell(withIdentifier: "OneTVC") as! CommunityOneTVC
        let twoTVC = communityTableView.dequeueReusableCell(withIdentifier: "TwoTVC") as! CommunityTwoTVC
        let threeTVC = communityTableView.dequeueReusableCell(withIdentifier: "ThreeTVC") as! CommunityThreeTVC
        let fourTVC = communityTableView.dequeueReusableCell(withIdentifier: "FourTVC") as! CommunityFourTVC
        
        let community = communityList[indexPath.row]
        
        let date: String = gsno(community.createdAt)
        
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy년 MM월 dd일"
        
        
        let beforeDate: Date = fmt.date(from: date) ?? Date()
        let afterDate: String = fmt.string(from: beforeDate)
        
        
        switch (community.communityImgList?.count) {
        case 0:
            oneTVC.uploadImage1.image = UIImage(named: "communityNoimg")!
            oneTVC.title.text = community.title
            oneTVC.profileImage.imageFromUrl(gsno(community.userProfileImg), defaultImgPath: "")
            oneTVC.writeTime.text = afterDate
//            oneTVC.writeTime.text = gsno(community.createdAt)
            oneTVC.userId.text = community.userId
            
            return oneTVC
        case 1:
            oneTVC.uploadImage1.imageFromUrl(gsno(community.communityImgList![0].filePath), defaultImgPath: "")
            oneTVC.title.text = community.title
            oneTVC.profileImage.imageFromUrl(gsno(community.userProfileImg), defaultImgPath: "")
            oneTVC.writeTime.text = afterDate
//            oneTVC.writeTime.text = gsno(community.createdAt)
            oneTVC.userId.text = community.userId
            
            return oneTVC
        case 2:
            twoTVC.uploadImage1.imageFromUrl(gsno(community.communityImgList![0].filePath), defaultImgPath: "")
            twoTVC.uploadImage2.imageFromUrl(gsno(community.communityImgList![1].filePath), defaultImgPath: "")
            twoTVC.title.text = community.title
            twoTVC.profileImage.imageFromUrl(gsno(community.userProfileImg), defaultImgPath: "")
            twoTVC.writeTime.text = afterDate
//            twoTVC.writeTime.text = gsno(community.createdAt)
            twoTVC.userId.text = community.userId
            
            return twoTVC
        case 3:
            threeTVC.uploadImage1.imageFromUrl(gsno(community.communityImgList![0].filePath), defaultImgPath: "")
            threeTVC.uploadImage2.imageFromUrl(gsno(community.communityImgList![1].filePath), defaultImgPath: "")
            threeTVC.uploadImage3.imageFromUrl(gsno(community.communityImgList![2].filePath), defaultImgPath: "")
            threeTVC.title.text = community.title
            threeTVC.profileImage.imageFromUrl(gsno(community.userProfileImg), defaultImgPath: "")
            threeTVC.writeTime.text = afterDate
//            threeTVC.writeTime.text = gsno(community.createdAt)
            threeTVC.userId.text = community.userId
            
            return threeTVC
        case 4:
            fourTVC.uploadImage1.imageFromUrl(gsno(community.communityImgList![0].filePath), defaultImgPath: "")
            fourTVC.uploadImage2.imageFromUrl(gsno(community.communityImgList![1].filePath), defaultImgPath: "")
            fourTVC.uploadImage3.imageFromUrl(gsno(community.communityImgList![2].filePath), defaultImgPath: "")
            fourTVC.title.text = community.title
            fourTVC.profileImage.imageFromUrl(gsno(community.userProfileImg), defaultImgPath: "")
            fourTVC.writeTime.text = afterDate
//            fourTVC.writeTime.text = gsno(community.createdAt)
            fourTVC.userId.text = community.userId
            
            return fourTVC
        default:
            oneTVC.uploadImage1.imageFromUrl(gsno(community.communityImgList![0].filePath), defaultImgPath: "")
            oneTVC.title.text = community.title
            oneTVC.profileImage.imageFromUrl(gsno(community.userProfileImg), defaultImgPath: "")
            oneTVC.writeTime.text = afterDate
            oneTVC.writeTime.text = gsno(community.createdAt)
            oneTVC.userId.text = community.userId
            
            return oneTVC
        }
    }
}
extension CommunityVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "CommunityDetailVC") as! CommunityDetailVC
        
        let community = communityList[indexPath.row]
        
        print(community)
        
        detailVC.communityIdx = community.id
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

