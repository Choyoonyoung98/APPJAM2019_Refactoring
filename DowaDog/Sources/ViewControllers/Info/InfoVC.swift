//
//  InfoVC.swift
//  DowaDog
//
//  Created by wookeon on 04/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarClear()
    }
    
    @IBAction func xBtnAction(_ sender: UIStoryboardSegue) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
}
