//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct Education: Mappable {
    
    var id: Int?
    var title: String?
    var subtitle: String?
    var imgPath: String?
    var educated: Bool?
    var auth: Bool?
    var scrap: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        imgPath <- map["imgPath"]
        educated <- map["educated"]
        auth <- map["auth"]
        
        scrap <- map["scrap"]
    }
}
