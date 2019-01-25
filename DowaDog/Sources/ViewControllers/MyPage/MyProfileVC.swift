//
//  MyProfileVC.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var confirmItem : UIBarButtonItem!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var birth: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var flag = false
    
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self

        confirmItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(confirmTapped))
        confirmItem.tintColor = UIColor.init(displayP3Red: 1, green: 194/255, blue: 51/255, alpha: 1)
        
        navigationItem.rightBarButtonItems = [ confirmItem ]
        
        setupTap()
        
        profileImage.circleImageView()
        
        initGestureRecognizer()
        
        self.title = "개인 정보 수정"
        
        email.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("transfer=========")
        MyInfoService.shared.getMyInfo() {
            (data) in
            
            print("data ===================")
            print(data)
            print("data ===================")
           
            if self.flag == false {
                self.profileImage.imageFromUrl(data.data?.thumbnailImg, defaultImgPath: "")
            }
            
            self.name.text = self.gsno(data.data?.name)
            self.birth.text = self.gsno(data.data?.birth)
            self.phone.text = self.gsno(data.data?.phone)
            self.email.text = self.gsno(data.data?.email)

        }
        print("transfer=========")
    }

    
    @objc func confirmTapped(){
        
        print("transfer=========")
        
        guard let name = self.name.text else {return}
        guard let birth = self.birth.text else {return}
        guard let phone = self.phone.text else {return}
        guard let profileImg = self.profileImage.image else {return}
        guard let email = self.email.text else {return}
        
        
        MyInfoEditService.shared.putMyInfo(name: name, phone: phone, email: email, birth: birth, profileImgFile: profileImg ) {
            (data) in
            
            print("data ===================")
            print(data)
            print("data ===================")
        }
        print("transfer=========")
        
            navigationController?.popViewController(animated: true)
    }
    

    func setupTap() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        self.profileImage.addGestureRecognizer(imageTap)
    }
    

    // image Tapped
    @objc func imageTapped() {
        
        
        let actionSheet = UIAlertController(title: "사진 첨부", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "카메라", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.sourceType = .camera
                self.picker.allowsEditing = true
                self.picker.showsCameraControls = true
                self.present(self.picker, animated: true)
            } else {
                print("not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "앨범", style: .default, handler: { (action) in
            self.picker.sourceType = .photoLibrary
            self.picker.allowsEditing = true
            self.present(self.picker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(actionSheet, animated: true)
    }

}


extension MyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //이미지를 선택하지 않고 피커 종료시에 실행되는 delegate 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
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
        self.flag = true
        
        
        self.profileImage.image = newImg
        
        dismiss(animated: true, completion: nil)
    }
}

extension MyProfileVC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer){
        self.resignFirstResponder()
        self.name.resignFirstResponder()
        self.birth.resignFirstResponder()
        self.phone.resignFirstResponder()
        self.email.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of:name))! || (touch.view?.isDescendant(of: birth))! || (touch.view?.isDescendant(of: phone))! || (touch.view?.isDescendant(of: email))! {
            
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
