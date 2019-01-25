//
//  AdoptDocEndVC.swift
//  DowaDog
//
//  Created by wookeon on 03/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class AdoptDocEndVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func unwindAction(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
}
