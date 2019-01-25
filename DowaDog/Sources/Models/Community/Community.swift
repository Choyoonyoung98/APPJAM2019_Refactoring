//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct Community<T: Mappable>: Mappable {
    
    var id: Int?
    var title: String?
    var detail: String?
    var communityImgList: [T]?
    var today: Bool?
    var userId: String?
    var userProfileImg: String?
    var createdAt: String?
    var updatedAt: String?
    var auth: Bool?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        detail <- map["detail"]
        communityImgList <- map["communityImgList"]
        today <- map["today"]
        userId <- map["userId"]
        userProfileImg <- map["userProfileImg"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        auth <- map["auth"]
    }
}
