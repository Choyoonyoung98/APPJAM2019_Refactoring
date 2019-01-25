//
//  LoginVC.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var emptyCheck = false
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var aroundBtn: UIButton!
    
    
    @IBOutlet var constraint: NSLayoutConstraint!
    
    
    
    var token = [Token]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "Token") != nil {
            let login = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
            
            self.present(login, animated: true, completion: nil)
        }
        
        self.setNavigationBarClear()
        
        initGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        if idTextField.text == "" || pwTextField.text == "" {
            self.simpleAlert(title: "로그인 실패", message: "아이디 또는 비밀번호를 확인하세요")
        } else {
            guard let id = idTextField.text else { return }
            guard let password = pwTextField.text else { return }
            
            LoginService.shared.login(id: id, password: password) { (data) in
                
                
                if data.message == "로그인 성공" {
                    
                    
                    UserDefaults.standard.set(data.data?.refreshToken?.data, forKey: "Token")
                    
                    let login = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
                    
                    self.present(login, animated: true, completion: nil)
                } else {
                    self.simpleAlert(title: "로그인 실패", message: "아이디 또는 비밀번호를 확인하세요")
                }
            }
            self.view.endEditing(true)
        }
    }
    
    @IBAction func noLoginAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "Token")
        
        let login = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
        
        self.present(login, animated: true, completion: nil)
    }
    
    @IBAction func unwindAction(_ sender: UIStoryboardSegue) {}
}


extension LoginVC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer){
        self.idTextField.resignFirstResponder()
        self.pwTextField.resignFirstResponder()
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: idTextField))! || (touch.view?.isDescendant(of: pwTextField))! {
            
            return false
        }
        return true
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.constraint.constant = 32
        })
        
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.constraint.constant = 87
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

