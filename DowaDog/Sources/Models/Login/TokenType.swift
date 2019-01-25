//
//  ReponseArray.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct TokenType: Mappable {
    
    var accessToken: Token?
    var refreshToken: Token?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        accessToken <- map["accessToken"]
        refreshToken <- map["refreshToken"]
    }
}
