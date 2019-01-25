//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct MyCommunityService: APIManager, Requestable {
    
    typealias NetworkData = ResponseArray<Community<CommunityImgList>>
    static let shared = MyCommunityService()
    let myCommunityURL = url("/api/normal/mypage/community")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 마이페이지 조회
    func getMyCommunity(completion: @escaping ([Community<CommunityImgList>]) -> Void) {
        
        gettable(myCommunityURL, body: nil, header: headers) { res in
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
