//
//  AdoptDocStep3VC.swift
//  DowaDog
//
//  Created by wookeon on 02/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class AdoptDocStep3TempVC: UIViewController {

    @IBOutlet var textFieldConstraint: NSLayoutConstraint!

    @IBOutlet var periodView: UIView!
    @IBOutlet var textField: UITextField!

    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var agreeBtn: UIButton!
    
    var id:Int!
    var getDogProfile:UIImage!
    var getHave:Bool!
    var getDetail:String!
    var getPhoneNumb:String!
    var getEmail:String!
    var getAddress:String!
    var getWork:String!

    

    let normalColor: UIColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
    let selectColor: UIColor = UIColor(red: 255/255, green: 194/255, blue: 51/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBackBtn()
        self.setNavigationBarClear()
        periodView.layer.cornerRadius = periodView.layer.frame.size.height/2
        initGestureRecognizer()
    }

    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }

    func setTextField() {
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text != "" && agreeBtn.isSelected {
            nextBtn.backgroundColor = selectColor
        } else {
            nextBtn.backgroundColor = normalColor
        }
    }

    @IBAction func agreeBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        sender.setImage(UIImage(named:"adoptingDocumentCheckGrey"), for: .normal)
        sender.setImage(UIImage(named:"adoptingDocumentCheckYellow"), for: .selected)

        if textField.text != "" && sender.isSelected {
            nextBtn.backgroundColor = selectColor
        } else {
            nextBtn.backgroundColor = normalColor
        }

        self.view.endEditing(true)
    }

    @IBAction func nextBtnAction(_ sender: UIButton) {
       
        
    }
}

extension AdoptDocStep3TempVC: UIGestureRecognizerDelegate {

    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }

    @objc func handleTapTextField(_ sender: UITapGestureRecognizer){
        self.textField.resignFirstResponder()
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: textField))! {

            return false
        }
        return true
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {

        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}

        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.textFieldConstraint.constant = 80
        })

        self.view.layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.textFieldConstraint.constant = 149
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
