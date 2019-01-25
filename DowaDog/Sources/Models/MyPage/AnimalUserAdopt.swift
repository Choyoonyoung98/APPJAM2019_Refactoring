//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct AnimalUserAdopt: Mappable {
    
    var id: Int?
    var name: String?
    var gender: String?
    var kind: String?
    var age: String?
    var weight: String?
    var neuterYn: Bool?
    var profileImg: String?
    var adoptType: String?
    var inoculationArray: Array<String>?
    

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        gender <- map["gender"]
        kind <- map["kind"]
        age <- map["age"]
        weight <- map["weight"]
        neuterYn <- map["neuterYn"]
        profileImg <- map["profileImg"]
        adoptType <- map["adoptType"]
        inoculationArray <- map["inoculationArray"]
    }
}
