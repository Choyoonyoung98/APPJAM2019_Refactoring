//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct CommunityImgList: Mappable {
    
    
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var filePath: String?
    var originFileName: String?
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        filePath <- map["filePath"]
        originFileName <- map["originFileName"]
    }
}
