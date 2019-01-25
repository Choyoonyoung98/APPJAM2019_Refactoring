//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct MyInfoService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<MyInfo>
    static let shared = MyInfoService()
    let myInfoURL = url("/api/normal/mypage/myinfo")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 마이페이지 조회
    func getMyInfo(completion: @escaping (ResponseObject<MyInfo>) -> Void) {
        
        gettable(myInfoURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                completion(value)
            case .error(let error):
                print(".error============================")
                print("error: ")
                print(error)
                print(".error============================")
            }
        }
    }
}
