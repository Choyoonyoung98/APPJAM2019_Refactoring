//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct InoculationList: Mappable {
    
    var code: String?
    var codeName: String?
    var complete: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        code <- map["code"]
        codeName <- map["codeName"]
        complete <- map["complete"]
    }
    
    
}
