//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct EducationThumbnailService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<ContentDetail<Content>>
    static let shared = EducationThumbnailService()
    let educationDetailURL = url("/api/normal/cardnews")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // content 상세조회
    func getThumbnail(contentIdx: Int, completion: @escaping (String) -> Void) {
        
        let queryURL = educationDetailURL + "/\(contentIdx)/contents"
        
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                //                print(".success=========================")
                //                print("value: ")
                //                print(value)
                //                print(".success=========================")
                
                guard let data = value.data?.cardnewsThumbnail else {return}
                
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
