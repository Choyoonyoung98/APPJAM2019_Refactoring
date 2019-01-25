//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct ContentDetail<T: Mappable>: Mappable {
    
    var cardnewsThumbnail: String?
    var content: [T]?
    var edu: T?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        cardnewsThumbnail <- map["cardnewsThumbnail"]
        content <- map["content"]
        edu <- map["edu"]
    }
}
