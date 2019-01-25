//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct CommentService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<Comment>
    static let shared = CommentService()
    let communicationURL = url("/api/normal/community")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? "",
        "Content-Type" : "application/json"
    ]
    
    // 커뮤니티 글 목록 작성
    func postComment(communityIdx: Int, detail: String, completion: @escaping (ResponseObject<Comment>) -> Void) {
        
        let body = [
            "detail" : detail
        ]
        
        let queryURL = communicationURL + "/\(communityIdx)/comments"
        
        
        postable(queryURL, body: body, header: headers) { res in
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
