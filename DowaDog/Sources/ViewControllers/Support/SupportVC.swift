//
//  SupportVC.swift
//  DowaDog
//
//  Created by wookeon on 11/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class SupportVC: UIViewController {

    
    @IBOutlet var klorenz: UIImageView!
    @IBOutlet var fromella: UIImageView!
    @IBOutlet var petfit: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTapGestureRecognizer()
        setNavigationBarShadow()
    }
    
    func setTapGestureRecognizer() {
        klorenz.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openKlorenz)))
        
        fromella.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFromella)))
        
        petfit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPetfit)))
    }
    
    

    @IBAction func backBtnAction(_ sender: UIStoryboardSegue) {
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
    
    @objc func openKlorenz() {
        guard let klorenzURL = URL(string: "https://klorenz.com") else { return }
        UIApplication.shared.open(klorenzURL)
    }
    
    @objc func openFromella() {
        guard let fromellaURL = URL(string: "https://www.fromella.com") else {return}
        UIApplication.shared.open(fromellaURL)
    }
    
    @objc func openPetfit() {
        guard let petfitURL = URL(string: "http://www.wepetfit.com") else {return}
        UIApplication.shared.open(petfitURL)
    }
}
