//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct MyLikeList: Mappable {
    
    
    var id: Int?
    var type: String?
    var sexCd: String?
    var kindCd: String?
    var region: String?
    var noticeEddt: String?
    var liked: Bool?
    var remainDateState: Bool?
    var education: Bool?
    var thumbnailImg: String?
    var processState: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        type <- map["type"]
        sexCd <- map["sexCd"]
        kindCd <- map["kindCd"]
        region <- map["region"]
        noticeEddt <- map["noticeEddt"]
        liked <- map["liked"]
        remainDateState <- map["remainDateState"]
        education <- map["education"]
        thumbnailImg <- map["thumbnailImg"]
        processState <- map["processState"]
    }
}
