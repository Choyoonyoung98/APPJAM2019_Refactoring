//
//  CommunityWriteVC.swift
//  DowaDog
//
//  Created by wookeon on 29/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class CommunityWriteVC: UIViewController {
    
    
    // 제목, 내용, 사진
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    let placeholder: String = "여기를 눌러서 글을 작성할 수 있습니다.\n기다릴개에서 당신의 동물의 이야기를 들려주세요:)\n이미지는 최대 4장까지 첨부 가능합니다."
    let defaultImage = UIImage(named: "writingPlusBtn")
    var uploadImgArray: Array<UIImage> = []
    
    
    // uploadImage Button
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    var btnArray: Array<UIButton> = []
    // camera Button
    @IBOutlet var cameraBtn: UIButton!
    // boxView
    @IBOutlet var imageBox: UIView!
    // image Picker
    let picker = UIImagePickerController()
    
    
    // constraint
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    // keyboard Height
    var keyboardHeight: CGFloat = 0.0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init
        initImageBox()
        setBtnArray()
        setContentTextView()
        initGestureRecognizer()
        
        // delegate
        picker.delegate = self
        contentTextView.delegate = self
        
        
        
    }
    
    // 옵저버 할당
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    // 옵저버 해지
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    
    
    
    
    // imageBox 보이기, 숨기기
    func initImageBox() {
        self.imageBox.transform = CGAffineTransform(translationX: 0, y: self.imageBox.frame.height)
    }
    func showImageBox() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.imageBox.transform = .identity
        })
    }
    func hideImageBox() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.imageBox.transform = CGAffineTransform(translationX: 0, y: self.imageBox.frame.height)
        })
    }
    
    

    
    // 카메라 버튼 액션
    @IBAction func cameraBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            showImageBox()
        } else {
            hideImageBox()
        }
    }
    // 이미지 버튼 액션
    @IBAction func imgBtnAction(_ sender: UIButton) {
        if sender.currentImage == defaultImage {
            actionSheet()
        } else {
            uploadImgArray.remove(at: (sender.tag)-1)
            for i in 0..<uploadImgArray.count {
                btnArray[i].setImage(uploadImgArray[i], for: .normal)
            }
            btnArray[uploadImgArray.count].setImage(defaultImage, for: .normal)
            for i in uploadImgArray.endIndex+1..<btnArray.count {
                btnArray[i].isHidden = true
            }
        }
    }
    // 확인 버튼 액션
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        if titleTextField.text == "" {
            self.simpleAlert(title: "오류", message: "제목을 입력하세요.")
        } else if contentTextView.text == "" || contentTextView.text == placeholder {
            self.simpleAlert(title: "오류", message: "내용을 입력하세요.")
        } else {
            
            guard let title = titleTextField.text else {return}
            guard let detail = contentTextView.text else {return}
            
            CommunityWriteService.shared.writeCommunityWrite(title: title, detail: detail, communityImgFiles: uploadImgArray) {
                (data) in
                
                print("data=========================")
                print(data)
                print("data=========================")
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    // 취소 버튼 액션
    @IBAction func cancleBtnAction(_ sender: UIButton) {
        self.simpleAlertwithHandler(title: "경고", message: "글 작성을 취소하겠습니까?", okHandler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }, cancleHandler: nil)
    }
    
    // set button Array
    func setBtnArray() {
        btnArray = [btn1, btn2, btn3, btn4]
    }
    // contentTextView set Placeholder
    func setContentTextView() {
        contentTextView.text = placeholder
    }
    // set action sheet
    func actionSheet() {
        
        let actionSheet = UIAlertController(title: "사진 첨부", message: "사진은 최대 4장까지 업로드 가능합니다", preferredStyle: .actionSheet)
        
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




    // 하단 뷰를 키보드에 맞게 움직이는 작업
extension CommunityWriteVC: UIGestureRecognizerDelegate {
    func initGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextView(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTapTextView(_ sender: UITapGestureRecognizer) {
        self.contentTextView.resignFirstResponder()
        self.titleTextField.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: contentTextView))! || (touch.view?.isDescendant(of: titleTextField))! {
            
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
            self.bottomConstraint.constant = self.keyboardHeight
        })
        
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.bottomConstraint.constant = 0 //스택 뷰의 제약조건을 변경한다.
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

    // image picker extension
extension CommunityWriteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 이미지를 선택하지 않고 피커 종료시에 실행되는 delegate 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // 이미지 피커에서 이미지를 선택하였을 때 일어나는 이벤트를 작성하는 메소드
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
        
        self.uploadImgArray.append(newImg)
        
        let index = (uploadImgArray.endIndex)-1
        self.btnArray[index].setImage(newImg, for: .normal)
        
        if index < 3 {
            self.btnArray[index+1].isHidden = false
        }
        
        dismiss(animated: true, completion: nil)
    }
}

    // textView placeholder 설정
extension CommunityWriteVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.contentTextView.text == placeholder {
            self.contentTextView.text = ""
            self.contentTextView.textColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1.0)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.contentTextView.text == "" {
            self.contentTextView.text = placeholder
            self.contentTextView.textColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.0)
        }
    }
}
