//
//  User.swift
//  homework_4+5
//
//  Created by wookeon on 01/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct AdoptAnimalDetail<T: Mappable>: Mappable {
    
    var animalUserAdopt: T?
    var inoculationList: [T]?
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        animalUserAdopt <- map["animalUserAdopt"]
        inoculationList <- map["inoculationList"]
        
    }
}
