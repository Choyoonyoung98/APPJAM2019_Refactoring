//
//  HomeExtension.swift
//  DowaDog
//
//  Created by wookeon on 27/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    //스토리보드 idetifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    //네비게이션 바 투명하게 하는 함수
    func setNavigationBarClear() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    func setNavigationBarShadow() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.backgroundColor = UIColor.white
    }
    
    
    
    func setTopItem(title: String) {
        
        navigationItem.title = title
    }
    
    func setBackBtn(){
        
        let backBTN = UIBarButtonItem(image: UIImage(named: "backBtn"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(self.pop))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }

    //커스텀 left bar button
    func setLeftBtn(title: String, color : UIColor){
        
        let leftBTN = UIBarButtonItem(title: title, //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(self.pop))
        navigationItem.leftBarButtonItem = leftBTN
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    //커스텀 right bar button
    func setRightBtn(title: String, color : UIColor){
        
        let rightBTN = UIBarButtonItem(title: title, //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(self.pop))
        navigationItem.rightBarButtonItem = rightBTN
        navigationItem.rightBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // 유효성 검사 이메일
    func isValidEmailAddress(email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: email)
    }
    
    // 유효성 검사 아이디
    func isValidId(id: String) -> Bool {
        
        let idRegEx = "^[A-Z0-9a-z]{4,12}$"
        
        let idTest = NSPredicate(format:"SELF MATCHES %@", idRegEx)
        
        return idTest.evaluate(with: id)
    }
    
    // 유효성 검사
    func isValidName(name: String) -> Bool{
        
        let nameRegEx = "^[가-힣]{2,4}$"
        
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        
        return nameTest.evaluate(with: name)
    }
    
    func isValidBirth(birth: String) -> Bool {
        
        let birthRegEx = "^[0-9]{8}$"
        
        let birthTest = NSPredicate(format: "SELF MATCHES %@", birthRegEx)
        
        return birthTest.evaluate(with: birth)
    }
    
    func isValidPhone(phone: String) -> Bool {
        
        let phoneRegEx = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        
        return phoneTest.evaluate(with: phone)
    }
    
    func isValidPw(password: String) -> Bool {
        
        print("extension:\(password)")
        
        let pwRegEx = "^(?=.*[0-9])(?=.*[a-z]).{8,}$"
        
        let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
        
        return pwTest.evaluate(with: password)
    }
}

extension UIView {
    
    //뷰 라운드 처리 설정
    func makeRounded(cornerRadius : CGFloat?){
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            self.layer.cornerRadius = self.layer.frame.height/2
        }
        self.layer.masksToBounds = true
    }
    
    //뷰 그림자 설정
    //color: 색상, opacity: 그림자 투명도, offset: 그림자 위치, radius: 그림자 크기
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIImageView {
    
    //이미지뷰 동그랗게 설정
    func circleImageView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
}

extension UITextView {
    
    //텍스트뷰 스크롤 상단으로 초기화
    //따로 메소드를 호출하지 않아도 이 메소드가 extension에 선언된 것만으로 적용이 됩니다.
    override open func draw(_ rect: CGRect)
    {
        super.draw(rect)
        setContentOffset(CGPoint.zero, animated: false)
    }
}

extension CALayer {
    
    //뷰 테두리 설정
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer();
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}
