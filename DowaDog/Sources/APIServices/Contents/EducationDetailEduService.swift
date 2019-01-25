//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct EducationDetailEduService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<ContentDetail<Edu>>
    static let shared = EducationDetailEduService()
    let educationDetailURL = url("/api/normal/cardnews")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // content 상세조회
    func getContentDetail(contentIdx: Int, completion: @escaping (Edu) -> Void) {
        
        let queryURL = educationDetailURL + "/\(contentIdx)/contents"
        
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
//                print(".success=========================")
//                print("value: ")
//                print(value)
//                print(".success=========================")
                
                guard let data = value.data?.edu else {return}
                
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
