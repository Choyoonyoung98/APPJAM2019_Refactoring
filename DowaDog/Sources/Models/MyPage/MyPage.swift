//
//  ReponseArray.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import ObjectMapper

struct MyPage: Mappable {
    
    var userName: String?
    var profileImg: String?
    var userLike: Int?
    var userScrap: Int?
    var userCommunity: Int?
    var animalName: String?
    var mailboxUpdated: Bool?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        userName <- map["userName"]
        profileImg <- map["profileImg"]
        userLike <- map["userLike"]
        userScrap <- map["userScrap"]
        userCommunity <- map["userCommunity"]
        animalName <- map["animalName"]
        mailboxUpdated <- map["mailboxUpdated"]
    }
}
