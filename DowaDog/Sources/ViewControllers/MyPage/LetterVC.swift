//
//  LetterVC.swift
//  DowaDog
//
//  Created by 조윤영 on 04/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class LetterVC: UIViewController {

    var reusablecell = "MailCell"
    var header = "header"
//    var mailList = ResponseArray<Mailbox>()
    
    var mailboxList = [Mailbox]()
    

    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBtn()
        setNavigationBarShadow()
        self.title="편지"
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        print("refresh=========")
        
        
        print("transfer=========")
        
        MailboxService.shared.getMailbox() {
            (data) in
            
            self.mailboxList = data
            self.collectionView.reloadData()
            
            print("data ===================")
            print(data)
            print("data ===================")
            

        }
        
        MailboxService.shared.readMailbox() {
            (data) in
            
            print("data ===================")
            print(data)
            print("data ===================")
        }
        print("transfer=========")
    }
}

extension LetterVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mailboxList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: header,
                                                                   for: indexPath) as! MailCRView
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusablecell, for: indexPath) as! MailCell
        let mail = mailboxList[indexPath.row]

        cell.mailImage.imageFromUrl(gsno(mail.imgPath), defaultImgPath: "")
        cell.title.text = self.gsno(mail.title)
        cell.subtitle.text = self.gsno(mail.detail)
        return cell
        
    }
    
    
}

extension LetterVC: UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}


extension LetterVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width/1.16
        let height: CGFloat = view.frame.height / 4.94
        
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
}
