//
//  EmergenDog.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//
import ObjectMapper

struct EmergenDog: Mappable {
    
    var id:Int?
    var type:String?
    var sexCd:String?
    var kindCd:String?
    var region:String?
    var noticeEddt:String?
    var liked:Bool?
    var remainDateState:Bool?
    var education:Bool?
    var thumbnailImg:String?
    var processState:String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        type <- map["type"]
        sexCd <- map["sexCd"]
        region <- map["region"]
        remainDateState <- map["remainDateState"]
        noticeEddt <- map["noticeEddt"]
        kindCd <- map["kindCd"]
        thumbnailImg <- map["thumbnailImg"]
        liked <- map["liked"]
        education <- map["educationState"]
        processState <- map["processState"]        
    }
}
