//
//  CommunityDetailVC.swift
//  DowaDog
//
//  Created by wookeon on 05/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class CommunityDetailVC: UIViewController {
    
    
//    var replyList = [Community<CommunityImgList>]()
    var replyList = [Comment]()
    var reusablecell = "ReplyCell"

    @IBOutlet var tableView: UITableView!
    @IBOutlet var userIdTextView: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var aboutLabel: UITextView!
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var constraint: NSLayoutConstraint!
    
    // swipe
    @IBOutlet var leftSwipe: UISwipeGestureRecognizer!
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    
    
    @IBOutlet var replyTF: UITextField!
    var keyboardHeight: CGFloat = 0.0
    
    var imageArray: Array<String>?
    
    var communityIdx: Int?
    var comment: String?
    
    var id:Int!
    
    var imageIndex = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
    }
    
    // 옵저버 해지
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        CommunityDetailService.shared.getCommunityDetail(communityIdx: gino(communityIdx)) {
            (data) in
            
            for i in 0..<self.gino(data.communityImgList?.count) {
                self.imageArray?.append(self.gsno(data.communityImgList?[i].filePath))
            }
            
            
            self.userIdTextView.text = data.userId
            self.titleLabel.text = data.title
            self.dateLabel.text = data.createdAt
            self.aboutLabel.text = data.detail
            self.profileImage.imageFromUrl(data.userProfileImg, defaultImgPath: "")
            self.mainImage.imageFromUrl(data.communityImgList?[0].filePath, defaultImgPath: "")
        }
        
        CommentListService.shared.getCommunityList(communityIdx: gino(communityIdx)) {
            (data) in
            
            print(data)
           let replyList = data
        }
    }
    
    
    
    
    
    
    
    @IBAction func leftSwipeAction(_ sender: UISwipeGestureRecognizer) {
        if imageIndex < gino(imageArray?.count) {
            
            imageIndex += 1
            
            UIView.animate(withDuration: 0.3, animations: {
                self.mainImage.alpha = 0
            })
            
            self.mainImage.imageFromUrl(imageArray?[imageIndex], defaultImgPath: "")
            
            UIView.animate(withDuration: 0.3, animations: {
                self.mainImage.alpha = 1
            })
        }
            
        
            
            
    }
    
    
    @IBAction func rightSwipeAction(_ sender: UISwipeGestureRecognizer) {
        
    }
    
    
    @IBAction func writeAction(_ sender: Any) {
        
        if replyTF.text != "" {
            
            guard let communityIdx = self.communityIdx else {return}
            guard let comment = self.replyTF.text else {return}
                
            CommentService.shared.postComment(communityIdx: communityIdx, detail: comment) {
                (data) in
            
                
                
                print(data)
            }
        }
    }
    
    
    
    
}


extension CommunityDetailVC: UITableViewDelegate {
    
}



extension CommunityDetailVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replyList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusablecell, for:indexPath) as! ReplyCell
        
        
        let reply = replyList[indexPath.row]

        let date: String = gsno(reply.createdAt)

        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy.MM.dd"

        let showDate: Date = fmt.date(from:date) ?? Date()

        let afterDate: String = fmt.string(from: showDate)

        
        cell.idTextView.text = gsno(reply.userId)
        cell.profileImage.imageFromUrl(gsno(reply.userProfileImg), defaultImgPath: "")
            cell.replyTextView.text = gsno(reply.detail)
            cell.timeView.text = gsno(afterDate)
        
  

    return cell
    }

}


extension CommunityDetailVC: UIGestureRecognizerDelegate {
    func initGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextView(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTapTextView(_ sender: UITapGestureRecognizer) {
        self.replyTF.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: replyTF))! {
            
            return false
        }
        
        return true
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        
        
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.constraint.constant = self.keyboardHeight
        })
        
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.constraint.constant = 0
            
        })
        
        self.view.layoutIfNeeded()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
