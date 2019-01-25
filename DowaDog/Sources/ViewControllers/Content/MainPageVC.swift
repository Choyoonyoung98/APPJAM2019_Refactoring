//
//  MainPageVC.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class MainPageVC: UIViewController {
    
    
    @IBOutlet weak var page1CV: UIView!
    @IBOutlet weak var page2CV: UIView!
    
    
    @IBOutlet var blackscreen2: UIView!
    
    @IBOutlet weak var selectPoint1: UIView!
    
    @IBOutlet weak var selectPoint2: UIView!
    
    
    @IBOutlet weak var leadingC: NSLayoutConstraint!
    @IBOutlet weak var trailingC: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var tab1: UIButton!
    
    @IBOutlet weak var tab2: UIButton!

    
    // sidemenu
    @IBOutlet var sideMenuView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarShadow()
        self.setBlackScreen2()

        page2CV.alpha = 0.0
        self.selectPoint1.alpha = 1.0
           self.selectPoint2.alpha = 0.0
        
        
        self.tab2.setTitleColor(UIColor(red: 154.0/255.0, green: 154.0/255.0, blue: 154.0/255.0, alpha: 1.0), for: .normal)
        
        // sidemenu
        setSideMenu()
    }
    
    // sidemenu
    func setSideMenu() {
        self.sideMenuView.transform = CGAffineTransform(translationX: -self.sideMenuView.frame.width, y: 0)
    }
    
   
    
    @IBAction func menuTapped(_ sender: Any) {
        showMenu()
    }
    
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        hideMenu()
    }
    
    func showMenu() {
        self.navigationController?.navigationBar.layer.zPosition = -1
        
        UIView.animate(withDuration: 0.4, animations: {
            self.navigationController?.navigationBar.alpha = 0
            self.blackscreen2.alpha = 1
        })
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.sideMenuView.transform = .identity
        })
    }
    func hideMenu() {
        self.navigationController?.navigationBar.layer.zPosition = 1
        
        UIView.animate(withDuration: 0.4, animations: {
            self.navigationController?.navigationBar.alpha = 1
            self.blackscreen2.alpha = 0
        })
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.sideMenuView.transform = CGAffineTransform(translationX: -self.sideMenuView.frame.width, y: 0)
        })
    }
    
    func setBlackScreen2() {
        let tapGestRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(blackScreen2TapAction(sender:)))
        blackscreen2.addGestureRecognizer(tapGestRecognizer2)
    }
    
    @objc func blackScreen2TapAction(sender: UITapGestureRecognizer) {
        hideMenu()
    }
    
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
                
                let community = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityNav") as! UINavigationController
                
                self.present(community, animated: true, completion: nil)
                break
            case "컨텐츠":
                hideMenu()
                
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
                
                let support = UIStoryboard(name: "Support", bundle: nil).instantiateViewController(withIdentifier: "SupportVC") as! UINavigationController
                
                self.present(support, animated: true, completion: nil)
                break
            default:
                hideMenu()
                break
            }
        }
    }
    
    


    
    @IBAction func FirstPageAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, animations:{ self.selectPoint1.alpha = 1.0
            self.selectPoint2.alpha = 0.0
            
            
            self.tab2.setTitleColor(UIColor(red: 154.0/255.0, green: 154.0/255.0, blue: 154.0/255.0, alpha: 1.0), for: .normal)
            self.tab1.setTitleColor(UIColor.init(red: 255/255, green: 194/255, blue: 51/255, alpha: 1), for: .normal)
        
        })

        self.page1CV.alpha = 1.0
        self.page2CV.alpha = 0.0

    }
    
    
    @IBAction func SecondPageAction(_ sender: Any) {
        
        
        UIView.animate(withDuration: 0.2, animations:{ self.selectPoint1.alpha = 0.0
            self.selectPoint2.alpha = 1.0
            self.tab2.setTitleColor(UIColor.init(red: 255/255, green: 194/255, blue: 51/255, alpha: 1), for: .normal)
            self.tab1.setTitleColor(UIColor(red: 154.0/255.0, green: 154.0/255.0, blue: 154.0/255.0, alpha: 1.0), for: .normal)

        })
        
        self.page1CV.alpha = 0.0
        self.page2CV.alpha = 1.0
        
    }
    
    
    
}
