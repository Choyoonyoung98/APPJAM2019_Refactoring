//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct DuplicateService: APIManager, Requestable {
    
    typealias NetworkData = ResponseBool
    static let shared = DuplicateService()
    let signUpURL = url("/api/signup")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    // 이메일 중복검사 api
    func duplicateEmail(email: String, completion: @escaping (ResponseBool) -> Void) {
        let queryURL = signUpURL + "/duplicateEmail?email=\(email)"
        
        gettable(queryURL, body: nil, header: nil) { res in
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
    
    
    func duplicateId(id: String, completion: @escaping (ResponseBool) -> Void) {
        
        let queryURL = signUpURL + "/duplicateId?id=\(id)"

        let body = [
            "id" : id
        ]
        
        gettable(queryURL, body: body, header: headers) {
            res in
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
    
    
    
    
    func signUp(id: String, password: String, name: String, birth: String, phone: String, email: String, profileImgFile: UIImage, completion: @escaping (ResponseBool) -> Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type" : "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(id.data(using: .utf8)!, withName: "id")
            multipart.append(password.data(using: .utf8)!, withName: "password")
            multipart.append(name.data(using: .utf8)!, withName: "name")
            multipart.append(birth.data(using: .utf8)!, withName: "birth")
            multipart.append(phone.data(using: .utf8)!, withName: "phone")
            multipart.append(email.data(using: .utf8)!, withName: "email")
            multipart.append(profileImgFile.jpegData(compressionQuality: 0.5)!, withName: "profileImgFile", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: signUpURL,
           headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.responseObject { (res: DataResponse<ResponseBool>) in
                    switch res.result {
                    case .success(let value):
                        
                        
                        print(".success=========================")
                        print("value: ")
                        print(".success=========================")
                        
                        
                        completion(value)
                    case .failure(let error):
                        
                        print(".error============================")
                        print("error: ")
                        print(error)
                        print(".error============================")
                    }
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
}
