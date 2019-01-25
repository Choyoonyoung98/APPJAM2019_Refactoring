//
//  SignIn1VC.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//


//TODO: 코드 이쁘게 함수로 정리
//TODO: 키보드 이동 확인
//다음 버튼 활성화 시점 확인

import UIKit

class SignIn1VC: UIViewController {
    
    // 유효성 flag
    var birthTest: Bool = false
    var emailCheck: Bool = false
    var phoneTest: Bool = false
    
    // UI
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var birthTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumbTextField: UITextField!
    
    @IBOutlet var topConstraint: NSLayoutConstraint!
    
    // Outlet
    @IBOutlet var nextBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // init
        nextBtn.isEnabled = false
        initGestureRecognizer()
        setupTap()
        setTextFieldTarget()
        self.title = "개인 정보 입력"

        
        // navBar
        self.setNavigationBarShadow()
        self.setBackBtn()
        
        
        // UI
        profileImage.circleImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    
    
    // setGestureTap
    func setupTap() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.profileImage.addGestureRecognizer(imageTap)
    }
    
    // set textfield action @objc
    func setTextFieldTarget(){
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        birthTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        phoneNumbTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    // image Tapped
    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        self.present(picker, animated: true)
    }
    
    func setPhoneNumber(phone: String) -> String {
        
        var temp = Array(phone)
        
        var result: String = ""
        
        if temp.count == 10 {
            temp.insert("-", at: 3)
            temp.insert("-", at: 7)
        }
        
        if temp.count == 11 {
            temp.insert("-", at: 3)
            temp.insert("-", at: 8)
        }
        
        for i in 0..<temp.count {
            result.append(temp[i])
        }
        
        return result
    }
    
    // 유효성 검사 (빈칸)
    @objc func textFieldDidChange(textField: UITextField){
        
        if nameTextField.text != "" && birthTextField.text != "" && emailTextField.text != "" && phoneNumbTextField.text !=  "" {
            nextBtn.backgroundColor = UIColor(red: 255/255, green: 194/255, blue: 51/255, alpha: 1.0)
            nextBtn.isEnabled = true
        } else {
            nextBtn.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
            nextBtn.isEnabled = false
        }
        
        // 이메일 중복확인 이후에 데이터 수정이 발생할 시 작동
        if textField == emailTextField && emailCheck == true {
            emailCheck = false
        }
    }
    
    // 유효성 검사 (이메일)
    @IBAction func emailCheckAction(_ sender: UIButton) {
        
        let test = isValidEmailAddress(email: emailTextField.text!)
        
        // 유효성 검사 (이메일 형식)
        if test {
            guard let email = emailTextField.text else { return }
            
            // 유효성 검사 (이메일 중복: 통신)
            DuplicateService.shared.duplicateEmail(email: email) { (data) in
                
                if data.data == false{
                    self.simpleAlert(title: "성공", message: "등록 가능한 이메일입니다.")
                    self.emailCheck = true
                } else if data.data == true {
                    self.simpleAlert(title: "실패", message: "이미 사용 중인 이메일입니다.")
                    self.emailCheck = false
                }
            }
            
        } else {
            self.simpleAlert(title: "유효하지 않은 이메일", message: "이메일 형식을 확인하세요.")
        }
        
        // end editing
        self.view.endEditing(true)
    }
    
    @IBAction func nextBtnAction(_ sender: UIStoryboardSegue) {
        if nextBtn.backgroundColor == UIColor(red: 255/255, green: 194/255, blue: 51/255, alpha: 1.0) {
            
            let nameTest = isValidName(name: gsno(nameTextField.text))
            let birthTest = isValidBirth(birth: gsno(birthTextField.text))
            let phoneTest = isValidPhone(phone: gsno(phoneNumbTextField.text))
            
            if nameTest {
                if birthTest {
                    if phoneTest {
                        if emailCheck {
                            let name = nameTextField.text
                            let birth = birthTextField.text
                            let email = emailTextField.text
                            let numb = phoneNumbTextField.text
                            let profile = profileImage.image

                            if let dvc = self.storyboard?.instantiateViewController(withIdentifier: "SignUp2VC") as? SignIn2VC {
                                dvc.name = name
                                dvc.birth = birth
                                dvc.email = email
                                dvc.numb = numb
                                dvc.profileImage = profile

                                self.navigationController?.pushViewController(dvc, animated: true)
                            }
                        } else { self.simpleAlert(title: "경고", message: "이메일 중복체크를 확인하세요.")}
                    } else { self.simpleAlert(title: "경고", message: "전화번호를 확인하세요.") }
                } else { self.simpleAlert(title: "경고", message: "생년월일을 확인하세요.") }
            } else { self.simpleAlert(title: "경고", message: "이름을 확인하세요.") }
        }
    }
}










// image picker set
extension SignIn1VC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //이미지를 선택하지 않고 피커 종료시에 실행되는 delegate 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //이미지 피커에서 이미지를 선택하였을 때 일어나는 이벤트를 작성하는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImg = UIImage()
        
        if let possibleImg = info[.editedImage] as? UIImage {
            newImg = possibleImg
            
        }
        else if let possibleImg = info[.originalImage] as? UIImage {
            newImg = possibleImg
        }
        else {
            return
        }
        profileImage.image = newImg
        
        dismiss(animated: true, completion: nil)
    }
}













// Gesture Recognizer
extension SignIn1VC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer){
        self.nameTextField.resignFirstResponder()
        self.birthTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.phoneNumbTextField.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: nameTextField))! || (touch.view?.isDescendant(of: birthTextField))! || (touch.view?.isDescendant(of: emailTextField))! || (touch.view?.isDescendant(of: phoneNumbTextField))! {
            
            return false
        }
        return true
    }
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.topConstraint.constant = -80
        })
        
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.topConstraint.constant = 79
        })
        
        if phoneNumbTextField.text != "" {
            phoneNumbTextField.text = setPhoneNumber(phone: gsno(phoneNumbTextField.text))
        }
        
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
