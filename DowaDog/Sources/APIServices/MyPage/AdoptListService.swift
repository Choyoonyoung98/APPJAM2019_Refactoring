//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct AdoptListService: APIManager, Requestable {
    
    typealias NetworkData = ResponseArray<AnimalUserAdopt>
    static let shared = AdoptListService()
    let adoptListURL = url("/api/normal/mypage/adoptAnimals")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 사용자 입양 동물 리스트 조회
    func getAdoptList(completion: @escaping ([AnimalUserAdopt]) -> Void) {
        
        gettable(adoptListURL, body: nil, header: headers) { res in
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
