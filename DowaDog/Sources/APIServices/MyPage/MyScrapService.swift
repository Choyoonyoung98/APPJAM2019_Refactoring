//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct MyScrapService: APIManager, Requestable {
    
    typealias NetworkData = ResponseArray<MyScrap>
    static let shared = MyScrapService()
    let myScrapURL = url("/api/normal/mypage/scraps")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 마이페이지 조회
    func getMyScrap(completion: @escaping ([MyScrap]) -> Void) {
        
        gettable(myScrapURL, body: nil, header: headers) { res in
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
