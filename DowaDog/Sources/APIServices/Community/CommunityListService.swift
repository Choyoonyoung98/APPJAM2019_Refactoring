//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct CommunityListService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<ContentArray<Community<CommunityImgList>>>
    static let shared = CommunityListService()
    let communicationURL = url("/api/normal/community")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 커뮤니티 글 목록 조회
    func getCommunityList(page: Int, limit: Int,completion: @escaping ([Community<CommunityImgList>]) -> Void) {
        
        let queryURL = communicationURL + "?page=\(page)&limit=\(limit)"
        
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data?.content else {return}
                
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
