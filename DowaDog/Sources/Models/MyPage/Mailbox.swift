//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct Mailbox: Mappable {
    
    var title: String?
    var detail: String?
    var type: String?
    var imgPath: String?
    var complete: Bool?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        title <- map["title"]
        detail <- map["detail"]
        type <- map["type"]
        imgPath <- map["imgPath"]
        complete <- map["complete"]
    }
}
