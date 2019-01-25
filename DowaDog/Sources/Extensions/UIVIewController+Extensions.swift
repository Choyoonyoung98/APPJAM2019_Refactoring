//
//  UIViewController+Extensions.swift
//  homework_4+5
//
//  Created by wookeon on 02/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

extension UIViewController {
    func gsno(_ value:String?) -> String{
        guard let value_ = value else {
            return ""
        }
        return value_
    }//func gsno
    
    func gano(_ value: Array<Any>?) -> Array<Any>{
        guard let value_ = value else {
            return []
        }
        return value_
    }//func gano
    
    func gino(_ value:Int?) -> Int{
        guard let value_ = value else {
            return 0
        }
        return value_
    }//func gino
    
    func gbno(_ value:Bool?) -> Bool{
        guard let value_ = value else {
            return false
        }
        return value_
    }//func gbno
    
    func gfno(_ value:Float?) -> Float{
        guard let value_ = value else{
            return 0
        }
        return value_
    }//func gfno
}

