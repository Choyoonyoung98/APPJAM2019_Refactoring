//
//  SignIn2VC.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit



class SignIn2VC: UIViewController {
    
    // send variables
    var name:String?
    var birth:String?
    var email:String?
    var numb:String?
    var profileImage: UIImage?
    
    // valid flag
    var emptyCheck = false
    var idCheck = false
    
    // UI
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwCheckTextField: UITextField!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    // Outlet
    @IBOutlet weak var nextBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // init
        nextBtn.isEnabled = false
        initGestureRecognizer()
        setTarget()
        profile.circleImageView()
        self.title = "개인 정보 입력"
        
        // navBar
        self.setNavigationBarShadow()
        self.setBackBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        profile.image = profileImage
        
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    
    // set
    func setTarget(){
        idTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        pwCheckTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    
   
    // 유효성 검사 (빈칸)
    @objc func textFieldDidChange(textField: UITextField) {
        
        if idTextField.text != "" && pwTextField.text != "" && pwCheckTextField.text != "" {
            nextBtn.backgroundColor = UIColor(red: 255/255, green: 194/255, blue: 51/255, alpha: 1.0)
            nextBtn.isEnabled = true
        } else {
            nextBtn.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
            nextBtn.isEnabled = false
        }
        
        // 아이디 중복확인 이후에 데이터 수정이 발생할 시 작동
        if textField == idTextField && idCheck == true {
            idCheck = false
        }
    }
    
    // 유효성 검사 (아이디 중복체크)
    @IBAction func checkIdAction(_ sender: Any) {
        
        let test = isValidId(id: idTextField.text!)
        
        if test {
            guard let id = idTextField.text else {return}
            print("여기")
            
            DuplicateService.shared.duplicateId(id: id) {
                (data) in
                
                print(data)
                
                print("성공")
                
                if data.data == false {
                    
                    self.simpleAlert(title: "성공", message: "사용 가능한 아이디입니다.")
                    self.idCheck = true
                    
                }
                else if data.data == true {
                    
                    self.simpleAlert(title: "실패", message: "이미 사용중인 아이디입니다.")
                    self.idCheck = false
                }
            }
        } else {
            self.simpleAlert(title: "유효하지 않은 아이디", message: "숫자와 문자 포함 4~12자리")
            self.idCheck = false
        }
    }
    
    
    
    // submit action
    @IBAction func submitAction(_ sender: UIButton) {
        
        let pwTest = isValidPw(password: gsno(pwTextField.text))
        
        print("vc:\(gsno(pwTextField.text))")
        
        
        if idCheck {
            if pwTest {
                if pwTextField.text == pwCheckTextField.text {
                    
                    guard let id = idTextField.text else{return}
                    guard let password = pwTextField.text else{return}
                    guard let name = name else{ return}
                    guard let birth = birth else{return}
                    guard let phone = numb else{return}
                    guard let email = email else{return}
                    guard let profile = profileImage else{return}
                    
                    DuplicateService.shared.signUp(id: id, password: password, name: name, birth: birth, phone: phone, email: email, profileImgFile: profile) {
                        (data) in
                        
                        self.simpleAlert(title: "회원가입 성공!", message: "로그인하세요.")
                    }
                    
                    self.performSegue(withIdentifier: "goToLoginVC", sender: self)
                    
                } else { self.simpleAlert(title: "경고", message: "비밀번호가 일치하지 않습니다.")}
            } else { self.simpleAlert(title: "유효하지 않은 비밀번호", message: "숫자와 문자 포함 8자리 이상")}
        } else { self.simpleAlert(title: "경고", message: "아이디 중복체크를 확인하세요.")}
    }
}




// Gesture Recognizer Delegate
extension SignIn2VC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer){
        self.idTextField.resignFirstResponder()
        self.pwTextField.resignFirstResponder()
        self.pwCheckTextField.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: idTextField))! || (touch.view?.isDescendant(of: pwTextField))! || (touch.view?.isDescendant(of: pwCheckTextField))! {
            
            return false
        }
        return true
    }
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.topConstraint.constant = -5
        })
        
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.topConstraint.constant = 79
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
