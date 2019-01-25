//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct MyInfoEditService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<User>
    static let shared = MyInfoEditService()
    let myPageURL = url("/api/normal/mypage")
    let headers: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 사용자 정보 수정
    func putMyInfo(name: String, phone: String, email: String, birth: String, profileImgFile: UIImage, completion: @escaping (ResponseObject<User>) -> Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "Authorization" : UserDefaults.standard.string(forKey: "Token") ?? ""
        ]
        
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(name.data(using: .utf8)!, withName: "name")
            multipart.append(phone.data(using: .utf8)!, withName: "phone")
            multipart.append(email.data(using: .utf8)!, withName: "email")
            multipart.append(birth.data(using: .utf8)!, withName: "birth")
            multipart.append(profileImgFile.jpegData(compressionQuality: 0.5)!, withName: "profileImgFile", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: myPageURL, method: .put,
           headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.responseObject { (res: DataResponse<ResponseObject<User>>) in
                    switch res.result {
                    case .success(let value):
                        
                        
                        print(".success=========================")
                        print("value: ")
                        print(value)
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
