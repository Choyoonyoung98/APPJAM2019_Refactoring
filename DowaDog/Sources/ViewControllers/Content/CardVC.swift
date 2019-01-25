//
//  CardVC.swift
//  DowaDog
//
//  Created by 조윤영 on 02/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class CardVC: UIViewController, UIScrollViewDelegate {
    var scrapClick = false
    var scrapItem: UIBarButtonItem!
    
    var contentList = [Content]()
    
    
    @IBOutlet weak var completeBtn: UIButton!
    
    
    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.delegate = self
        self.setNavigationBar()
        setBackBtn()
        
        
        scrapItem = UIBarButtonItem(image:UIImage(named: "categoryUnscrabBtn.png") , style: .plain, target: self, action: #selector(scrapTapped))
        scrapItem.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItems = [scrapItem]
        
        
        
        let panGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_ :)))
        
        self.view.addGestureRecognizer(panGestureRecongnizer)
        
        panGestureRecongnizer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        EducationDetailContentService.shared.getContentDetail(contentIdx: 24) {
            (data) in
            
            print("CardVC content==============================")
            print("data: ")
            print(data)
            print("CardVc content==============================")
            
            self.contentList = data
        }
        
        EducationDetailEduService.shared.getContentDetail(contentIdx: 24) {
            (data) in
            
            
            print("CardVc education==============================")
            print("data: ")
            print(data)
            print("CardVc education==============================")
        }
        
    }
    
    @objc func scrapTapped(){
        
        EducationListService.shared.contentScrap(contentIdx: 25) {
            (data) in
            
            print("scrap==================")
            print("data: ")
            print(data)
            print("scrap==================")
        }
        
        
        
        
        if scrapClick == false{
            scrapItem.image = UIImage(named: "categoryScrabBtn.png")
            scrapClick = true
        }else{
            scrapItem.image = UIImage(named: "categoryUnscrabBtn.png")
            scrapClick = false
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scroll.contentOffset.y
        if ( offsetY > 276) { //흰색으로 바뀌어야할때
            UIView.animate(withDuration: 0.4, animations: {
                print("흰색")
                self.navigationController?.navigationBar.shadowImage = nil
                
//                self.scrapItem.tintColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
                
            })
            
        } else if (offsetY <= 276 ){
            UIView.animate(withDuration: 0.4, animations: {
//                self.navBarBackgroundAlpha = 0//navbar 투명하게 setup
//                self.scrapItem.tintColor = UIColor.white
                print("투명")
            })
            
        }
    }
    
    
    @objc func panAction (_ sender : UIPanGestureRecognizer){
        
        let velocity = sender.velocity(in: scroll)
        
        if abs(velocity.x) > abs(velocity.y) {
            
    
            
        }
            
//        else if abs(velocity.y) > abs(velocity.x) {
//
//        let offsetY = scroll.contentOffset.y
//        if ( offsetY > 276) {
//            UIView.animate(withDuration: 0.4, animations: {
//                self.navBarBackgroundAlpha = 1//navbar 투명하게 setup
//
//                self.scrapItem.tintColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
//
//            })
//
//        } else if (offsetY <= 276 ){
//            UIView.animate(withDuration: 0.4, animations: {
//                self.navBarBackgroundAlpha = 0//navbar 투명하게 setup
//                self.scrapItem.tintColor = UIColor.white
//                })
//
//            }
//        }
    }
    
    @IBAction func completeBtnAction(_ sender: UIButton) {
        
        EducationListService.shared.contentComplete(contentIdx: 25) {
            (data) in
            
            print("complete==================")
            print("data: ")
            print(data)
            print("complete==================")
        }
    }
    
    
    
    
    
    
    
    
}
extension CardVC : UIGestureRecognizerDelegate{
    
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        
        return true
        
    }
    
}
