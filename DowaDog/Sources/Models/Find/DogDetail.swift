//
//  NewDog.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import ObjectMapper

struct DogDetail: Mappable {
    
    var id: Int?
    var type: String?
    var processState: String?
    var sexCd: String?
    var startDate: String?
    var endDate: String?
    var region: String?
    var specialMark: String?
    var remainDateState: Bool?
    var kindCd: String?
    var age: String?
    var weight: String?
    var thumbnailImg: String?
    var happenPlace: String?
    var careName: String?
    var careTel: String?
    var liked: Bool?
    var educationState: Bool?
    var animalStoryList: Array<String>?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        type <- map["type"]
        processState <- map["processState"]
        sexCd <- map["sexCd"]
        region <- map["region"]
        specialMark <- map["specialMark"]
        remainDateState <- map["remainDateState"]
        kindCd <- map["kindCd"]
        age <- map["age"]
        weight <- map["weight"]
        thumbnailImg <- map["thumbnailImg"]
        happenPlace <- map["happenPlace"]
        careName <- map["careName"]
        careTel <- map["careTel"]
        liked <- map["liked"]
        educationState <- map["educationState"]
        animalStoryList <- map["animalStoryList"]
    }
}
