//
//  SplashVC.swift
//  DowaDog
//
//  Created by wookeon on 12/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class SplashVC: UIViewController {

    @IBOutlet var splashImage: UIImageView!
    let delayInSeconds = 1.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage.gif(name: "splash")
        splashImage.image = image

        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            print("들어옴")
            
            let token = UserDefaults.standard.string(forKey: "Token")
                print("내토큰큰: \(token)")
            if token == nil { //토큰 없을 때
                print("로그인토큰큰: \(token)")
                let signVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNav")
                self.present(signVC, animated: true, completion: nil)
                
            } else { //토큰 있을 때 - 자동 로그인
                print("메인토큰큰: \(token)")
                let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNav")
                self.present(homeVC, animated: true)
            }
        }
    }
    


}
