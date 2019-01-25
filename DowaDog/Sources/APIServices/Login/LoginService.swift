//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct LoginService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<TokenType>
    static let shared = LoginService()
    let loginURL = url("/api/auth")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    // refresh Token
    func refresh(completion: @escaping (TokenType) -> Void) {
        
        let queryURL = loginURL + "/refresh"
        
        let headers: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Authorization" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoidGFla3l1bmcwNDAyIiwiaXNzIjoiZG93YWRvZyIsImV4cCI6MTU3ODI4NDQzOH0.MTN9ke4pknmiqwu29Je24mUWn56GVM8OEuCca4HEPqI"
        ]
        
        postable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                guard let token = value.data else {return}
                completion(token)
            case .error(let error):
                print(".error============================")
                print("error: ")
                print(error)
                print(".error============================")
            }
        }
    }
    
    // 로그인 api
    func login(id: String, password: String, completion: @escaping (ResponseObject<TokenType>) -> Void) {
        
        let queryURL = loginURL + "/login"
        
        let body = [
            "id" : id,
            "password" : password
        ]
        
        postable(queryURL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
                
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
