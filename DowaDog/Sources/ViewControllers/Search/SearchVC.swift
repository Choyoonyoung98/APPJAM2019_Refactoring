//
//  SearchVC.swift
//  DowaDog
//
//  Created by wookeon on 23/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

protocol SendDataDelegate {
    func sendData(data: String)
}

class SearchVC: UIViewController {
    
    var searchDogList = [EmergenDog]()
    
    var flag = true
    var searchWord:String?
    var delegate: SendDataDelegate?
    
    var keyboardHeight: CGFloat = 0.0
    
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var searchBtn: UIButton!
    @IBOutlet var keywordBtn1: keywordButton!
    @IBOutlet var keywordBtn2: keywordButton!
    @IBOutlet var keywordBtn3: keywordButton!
    @IBOutlet var keywordBtn4: keywordButton!
    @IBOutlet var keywordBtn5: keywordButton!
    @IBOutlet var keywordBtn6: keywordButton!
    @IBOutlet var keywordBtn7: keywordButton!
    @IBOutlet var keywordBtn8: keywordButton!
    @IBOutlet var keywordBtn9: keywordButton!
    
    
    
    @IBOutlet var constraint: NSLayoutConstraint!
    @IBOutlet var searchBtnConstraint: NSLayoutConstraint!
    
    @IBOutlet var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init
        self.setNavigationBarClear()

        
        
        searchTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        searchTF.clearButtonMode = .whileEditing
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MyInfoService.shared.getMyInfo() {
            (data) in
            
            self.userName.text = "\(self.gsno(data.data?.name))님,"
        }
        
        registerForKeyboardNotifications()
    }

    // 옵저버 해지
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        
        searchWord = searchTF.text
        
        EmergenDogService.shared.findAnimalList(type: "", region: "", remainNoticeDate: 300, searchWord: searchWord, page: 0, limit: 10){
            (data) in
            
            print("---여기--------------")
            print(data)
            print("---여기--------------")
            
            if data.count == 0 {
                self.flag  =  false
            } else {
                self.flag = true
            }
        }
        
        if searchTF.text != "" {
            searchBtn.backgroundColor = UIColor(red: 255/255, green: 194/255, blue: 51/255, alpha: 1.0)
        } else {
            searchBtn.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
        }
    }
    
    
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
    func findByHashtag(hashtag: String) {
        EmergenDogService.shared.findAnimalByHashTag(hashtag: hashtag) { (data) in
            
            print("data================")
            print(data)
            print("data================")
            
            
        }
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {

         searchWord = searchTF.text
        
        if sender.backgroundColor == UIColor(red: 255/255, green: 194/255, blue: 51/255, alpha: 1.0) {

            
            if let data = searchTF.text {
                delegate?.sendData(data: data)
            }
            
            if ( flag == true ) {
                performSegue(withIdentifier: "goResult", sender: self)
            } else {
                performSegue(withIdentifier: "goNoResult", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goResult"{
            
            let nextVC = segue.destination as! SearchResultVC
            
            nextVC.navTitle = searchTF.text!
            nextVC.searchWord = searchWord
        }
        
        if segue.identifier == "goNoResult" {
            
            let nextVC = segue.destination as! NoResultVC
            
            nextVC.navTitle = searchTF.text!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}



extension SearchVC: UIGestureRecognizerDelegate {
    func initGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextView(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTapTextView(_ sender: UITapGestureRecognizer) {
        self.searchTF.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: searchTF))! {
            
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
            self.searchBtnConstraint.constant = self.keyboardHeight
            self.constraint.constant = 16
        })
        
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.searchBtnConstraint.constant = 0
            self.constraint.constant = 46 //스택 뷰의 제약조건을 변경한다.
            
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
