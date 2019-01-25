//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct CommunityWrite: Mappable {
    
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var title: String?
    var detail: String?
    var communityImgList: Array<CommunityImgList>?
    var user: User?
    var removeImgArray: Array<Int>?
    var today: Bool?
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        title <- map["title"]
        detail <- map["detail"]
        communityImgList <- map["communityImgList"]
        user <- map["user"]
        removeImgArray <- map["removeImgArray"]
        today <- map["today"]
        
    }
}
