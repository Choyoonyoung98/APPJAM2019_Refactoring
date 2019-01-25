//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct AnimalUserAdoptDetailService: APIManager, Requestable {
    
    
    typealias NetworkData = ResponseObject<AdoptAnimalDetail<AnimalUserAdopt>>
    static let shared = AnimalUserAdoptDetailService()
    let adoptDetailURL = url("/api/normal/mypage/adoptAnimals")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 사용자 입양 동물 상세 조회
    func getAdoptAnimalDetail(adoptAnimalIdx: Int, completion: @escaping (AnimalUserAdopt) -> Void) {
        
        let queryURL = adoptDetailURL + "/\(adoptAnimalIdx)"
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                
                guard let data = value.data?.animalUserAdopt else {return}
                
                completion(data)
            case .error(let error):
                print(".error============================")
                print("error: ")
                print(error)
                print(".error============================")
            }
        }
    }
    
    
    func putAdoptAnimalDetail(adoptAnimalIdx: Int, name: String, gender: String, kind: String, weight:String, neuterYn: Bool, profileImgFile: UIImage, age: String, inoculationArray: Array<String>, completion: @escaping (ResponseObject<User>) -> Void) {
        
        
        let queryURL = adoptDetailURL + "/\(adoptAnimalIdx)"
        
        let headers: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "Authorization" : UserDefaults.standard.string(forKey: "Token") ?? ""
        ]
        
        let neuterYnString = String(neuterYn)
        
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(name.data(using: .utf8)!, withName: "name")
            multipart.append(gender.data(using: .utf8)!, withName: "gender")
            multipart.append(kind.data(using: .utf8)!, withName: "kind")
            multipart.append(weight.data(using: .utf8)!, withName: "weight")
            multipart.append(neuterYnString.data(using: .utf8)!, withName: "neuterYn")
        multipart.append(profileImgFile.jpegData(compressionQuality: 0.5)!, withName: "profileImgFile", fileName: "image.jpeg", mimeType: "image/jpeg")
            
            print("test=========")
            print(inoculationArray)
            print("inoculation Count : \(inoculationArray.count)")
            
            for i in 0..<inoculationArray.count {
                if let data = inoculationArray[i].data(using: .utf8) {
                    multipart.append(data, withName: "inoculationArray")
                }
            }
            
            multipart.append(age.data(using: .utf8)!, withName: "age")
            
        }, to: queryURL, method: .put,
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
