//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
    
    var id: String?
    var password: String?
    var name: String?
    var birth: String?
    var phone: String?
    var email: String?
    var gender: String?
    var deviceToken: String?
    var type: String?
    var profileImgFile: String?
    var pushAllow: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        password <- map["password"]
        name <- map["name"]
        birth <- map["birth"]
        phone <- map["phone"]
        email <- map["email"]
        gender <- map["gender"]
        deviceToken <- map["deviceToken"]
        type <- map["type"]
        profileImgFile <- map["profileImgFIle"]
        pushAllow <- map["pushAllow"]
    }
}
