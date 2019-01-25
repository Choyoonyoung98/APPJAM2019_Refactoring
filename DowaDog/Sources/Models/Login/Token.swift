//
//  ResponseObject.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct Token: Mappable {
    
    var data: String?
    var now: Int?
    var expiredAt: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        data <- map["data"]
        now <- map["now"]
        expiredAt <- map["expiredAt"]
    }
}
