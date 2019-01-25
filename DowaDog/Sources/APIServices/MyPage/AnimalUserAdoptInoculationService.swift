//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct AnimalUserAdoptInoculationService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<AdoptAnimalDetail<InoculationList>>
    static let shared = AnimalUserAdoptInoculationService()
    let adoptInoculationURL = url("/api/normal/mypage/adoptAnimals")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 사용자 입양 동물 상세 조회
    func getAdoptAnimalInoculation(adoptAnimalIdx: Int, completion: @escaping ([InoculationList]) -> Void) {
        
        let queryURL = adoptInoculationURL + "/\(adoptAnimalIdx)"
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                
                guard let data = value.data?.inoculationList else {return}
                
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
