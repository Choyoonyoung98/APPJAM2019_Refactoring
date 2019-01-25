//
//  MyPageMainVC.swift
//  DowaDog
//
//  Created by 조윤영 on 04/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MyPageMainVC: UIViewController {
    

    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userLike: UILabel!
    @IBOutlet weak var userScrap: UILabel!
    @IBOutlet weak var userCommunity: UILabel!
    @IBOutlet weak var mailbotUpdated: UIImageView!
    
    
    var str: String = "test1\ntest2"
    var strArray: Array<String> = []
    
    @IBOutlet weak var coverView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn()
        setNavigationBarClear()
        coverView.alpha = 0.0
        
        userProfile.circleImageView()
        
        strArray = str.components(separatedBy: "\n")
        
        print("================Array====================")
        print(strArray[0])
        print(strArray[1])
        print("================Array====================")
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.coverView.alpha = 0.5
            
        })
        simpleAlertwithHandler(title: "로그아웃 하시겠습니까?", message: "", okHandler:  {(alert: UIAlertAction!) in
            UIView.animate(withDuration: 0.3, animations: {
                self.coverView.alpha = 0.0
                
                UserDefaults.standard.removeObject(forKey: "Token")
                
                let logout = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
                
                self.present(logout, animated: true, completion: nil)
            })}
            , cancleHandler: {(alert: UIAlertAction!) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.coverView.alpha = 0.0
                })
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        print("refresh=========")
        
        LoginService.shared.refresh() {
            (data) in
            
            print("data ============")
            print(data)
            print("data ============")
            
            
            
        }
        print("refresh=========")
        
        print("transfer=========")
        
        MyPageService.shared.getMyPage() {
            (data) in

            print("data ===================")
            print(data)
            print("data ===================")
            
            
            
            self.userName.text = data.data?.userName
            self.userProfile.imageFromUrl(self.gsno(data.data?.profileImg), defaultImgPath: "")
            self.userLike.text = "\(self.gino(data.data?.userLike))"
            self.userScrap.text = "\(self.gino(data.data?.userScrap))"
            self.userCommunity.text = "\(self.gino(data.data?.userCommunity))"
           
            
            
            if data.data?.mailboxUpdated == true{
                self.mailbotUpdated.image = UIImage(named: "mypageNewIconB")
                
            }else if data.data?.mailboxUpdated == false{
                  self.mailbotUpdated.image = UIImage(named: "")
            }
            
            
        }
        print("transfer=========")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "setting1_show" {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem?.tintColor = UIColor.init(displayP3Red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
            
        } else if segue.identifier == "setting2_show" {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem?.tintColor = UIColor.init(displayP3Red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        }
    }
    
}
