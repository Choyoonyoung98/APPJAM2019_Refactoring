//
//  YoonExtension.swift
//  DowaDog
//
//  Created by 조윤영 on 30/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
//    //스토리보드 idetifier
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
}

extension UIViewController {
    //Toast
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
        //커스텀 백버튼 설정
        func setBackBtn(color : UIColor){
    
            let backBTN = UIBarButtonItem(image: UIImage(named: "backBtn"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
                style: .plain,
                target: self,
                action: #selector(self.pop))
            navigationItem.leftBarButtonItem = backBTN
            navigationItem.leftBarButtonItem?.tintColor = color
            navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        }
  
    
    //네비게이션 바 투명하게 하는 함수
    func setNavigationBar() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.backgroundColor = UIColor.clear
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()

    }
    
    
    func setNavigationSahdow(){
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.backgroundColor = UIColor.clear
        
    }

    //확인 팝업
    func simpleAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    //확인, 취소 팝업
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?,cancleHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: cancleHandler)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //커스텀 팝업 띄우기 애니메이션
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    //커스텀 팝업 끄기 애니메이션
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}


extension UIView {
    
    
    //뷰 라운드 처리 설정
    func circleRadius(){
        
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.masksToBounds = true
        
    }
    func roundRadius(){ //조금 라운드 주는 extension 만들 예정
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
    }
    func dropShadow(scale: Bool = true) {
        
        
        self.clipsToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 3
        
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func sectionRound(){
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        layer.mask = maskLayer
    }
    func sectionBottomRound(){
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        layer.mask = maskLayer
    }
    
    private func addBorder(_ mask: CAShapeLayer, borderWidth: CGFloat, borderColor: UIColor) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
        
    }
}



//extension UIImageView {
//
//    //이미지뷰 동그랗게 설정
//    func circleImageView() {
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = self.frame.width / 2
//    }
//}

//extension UITextView {
//
//    //텍스트뷰 스크롤 상단으로 초기화
//    //따로 메소드를 호출하지 않아도 이 메소드가 extension에 선언된 것만으로 적용이 됩니다.
//    override open func draw(_ rect: CGRect)
//    {
//        super.draw(rect)
//        setContentOffset(CGPoint.zero, animated: false)
//    }
//}
//
//extension CALayer {
//
//    //뷰 테두리 설정
//    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
//
//        let border = CALayer();
//
//        switch edge {
//        case UIRectEdge.top:
//            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
//            break
//        case UIRectEdge.bottom:
//            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
//            break
//        case UIRectEdge.left:
//            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
//            break
//        case UIRectEdge.right:
//            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
//            break
//        default:
//            break
//        }
//
//        border.backgroundColor = color.cgColor;
//
//        self.addSublayer(border)
//    }
//}
//
//

