//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct MyLikeListService: APIManager, Requestable {
    
    typealias NetworkData = ResponseArray<MyLikeList>
    static let shared = MyLikeListService()
    let myLikeListURL = url("/api/normal/mypage/likes")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 사용자 입양 동물 리스트 조회
    func getMyLikeList(completion: @escaping ([MyLikeList]) -> Void) {
        
        gettable(myLikeListURL, body: nil, header: headers) { res in
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
