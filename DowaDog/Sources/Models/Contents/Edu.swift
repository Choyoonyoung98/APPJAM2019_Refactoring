//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct Edu: Mappable {
    
    var allEducate: Int?
    var userEducated: Int?
    var allComplete: Bool?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        allEducate <- map["allEducate"]
        userEducated <- map["userEducated"]
        allComplete <- map["allComplete"]
    }
}
