//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct Comment: Mappable {
    
    var id: Int?
    var detail: String?
    var today: Bool?
    var userId: String?
    var createdAt: String?
    var updatedAt: String?
    var userProfileImg: String?
    var auth: Bool?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        detail <- map["detail"]
        today <- map["today"]
        userId <- map["userId"]
        userProfileImg <- map["userProfileImg"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        auth <- map["auth"]
    }
}
