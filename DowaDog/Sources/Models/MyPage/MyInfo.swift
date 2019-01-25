//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct MyInfo: Mappable {
    
    var name: String?
    var thumbnailImg: String?
    var birth: String?
    var phone: String?
    var email:String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        name <- map["name"]
        thumbnailImg <- map["thumbnailImg"]
        birth <- map["birth"]
        phone <- map["phone"]
        email <- map["email"]
    }
}
