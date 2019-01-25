//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct Content: Mappable {
    
    var id: Int?
    var title: String?
    var thumnailImg: String?
    var detail: String?
    var auth: Bool?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        thumnailImg <- map["thumnailImg"]
        detail <- map["detail"]
        auth <- map["auth"]
    }
}
