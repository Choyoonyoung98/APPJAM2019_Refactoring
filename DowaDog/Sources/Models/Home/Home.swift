//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct Home: Mappable {
    
    var login: Bool?
    var userCheck: Bool?
    var place: String?
    var time: String?
    var material: String?
    var totalCount: Int?
    var view: String?
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        login <- map["login"]
        userCheck <- map["userCheck"]
        place <- map["place"]
        time <- map["material"]
        material <- map["material"]
        totalCount <- map["totalCount"]
        view <- map["view"]
    }
}
