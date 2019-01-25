//
//  AdoptDirectVC.swift
//  DowaDog
//
//  Created by wookeon on 03/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class AdoptDirectVC: UIViewController {
    

    var callNumber = "0200000000"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackBtn()
        self.setNavigationBarClear()
    }
    
    
    @IBAction func callBtnAction(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://\(callNumber)") {
            let application: UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: {
                    (success) in

                    
                 
                    
                    if success {
                        self.simpleAlertwithHandler(title: "입양 신청이 완료되었나요?", message: "", okHandler: {
                            (action: UIAlertAction!) in
         
                            
                            let preferences = UserDefaults.standard
                            
                            let idKey = "id"
                            
                            if preferences.object(forKey: idKey) == nil {
                                print("nil값")
                            } else {
                                let getId = preferences.integer(forKey: idKey)
                                print("id 체크=======================")
                                print("\(getId)")
                                print("id 체크=======================")
                            
                            AdoptService.shared.requestOffline(animalIdx: getId) {
                                (data) in
                                
                                print("data ========================")
                                print(data)
                                print("data ========================")
                            }
                            }
                            
                        }, cancleHandler: nil)
                    }
                })
            }
        }
    }
}
