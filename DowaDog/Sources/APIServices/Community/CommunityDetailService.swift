//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct CommunityDetailService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<Community<CommunityImgList>>
    static let shared = CommunityDetailService()
    let communityURL = url("/api/normal/community")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 커뮤니티 글 목록 조회
    func getCommunityDetail(communityIdx: Int, completion: @escaping (Community<CommunityImgList>) -> Void) {
        
        let queryURL = communityURL + "/\(communityIdx)"
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data else {return}
                
                completion(data)
            case .error(let error):
                print(".error============================")
                print("error: ")
                print(error)
                print(".error============================")
            }
        }
    }
}
