//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct EmergenDogService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<ContentArray<EmergenDog>>
    static let shared = EmergenDogService()
    let emergenDogURL = url("/api/normal/animals")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    //모든 긴급 동물 게시글 조회 api
    func getEmergenDogList(page: Int?, limit: Int?, completion: @escaping ([EmergenDog]) -> Void) {
        
        let queryURL = emergenDogURL + "/emergency?page=\(page ?? 0)&limit=\(limit ?? 100)"
        let encodingURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        gettable(encodingURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data?.content else {return}
                
                completion(data)
            case .error(let error):
                
                print("error======================")
                print("error : ")
                print(error)
                print("error======================")
            }
        }
    }
    
    // Search with Hashtag
    func findAnimalByHashTag(hashtag: String, completion: @escaping ([EmergenDog]) -> Void) {
        
        let queryURL = emergenDogURL + "/hashtags?tag=\(hashtag)"
        let encodingURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        gettable(encodingURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data?.content else {return}
                
                completion(data)
            case .error(let error):
                
                print("error======================")
                print("error : ")
                print(error)
                print("error======================")
            }
        }
    }
    
    // Search without story
    func findAnimalList(type: String?, region: String?, remainNoticeDate: Int?, searchWord: String?, page: Int?, limit: Int?, completion: @escaping ([EmergenDog]) -> Void) {
        
        let queryURL = emergenDogURL +
            "?type=\(type ?? "")" +
            "&region=\(region ?? "")" +
            "&remainNoticeDate=\(remainNoticeDate ?? 8)" +
            "&searchWord=\(searchWord ?? "")" +
            "&page=\(page ?? 0)" +
        "&limit=\(limit ?? 10)"
        let encodingURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        gettable(encodingURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data?.content else {return}
                
                completion(data)
            case .error(let error):
                
                print("error======================")
                print("error : ")
                print(error)
                print("error======================")
            }
        }
    }
    
    // Search with story
    func findAnimalList(type: String?, region: String?, remainNoticeDate: Int?, story: Bool?, searchWord: String?, page: Int?, limit: Int?, completion: @escaping ([EmergenDog]) -> Void) {
        
        let queryURL = emergenDogURL +
            "?type=\(type ?? "")" +
            "&region=\(region ?? "")" +
            "&remainNoticeDate=\(remainNoticeDate ?? 300)" +
            "&story=\(story ?? true)" +
            "&searchWord=\(searchWord ?? "")" +
            "&page=\(page ?? 0)" +
        "&limit=\(limit ?? 10)"
        
        let encodingURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        gettable(encodingURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data?.content else {return}
                
                completion(data)
            case .error(let error):
                
                print("error======================")
                print("error : ")
                print(error)
                print("error======================")
            }
        }
    }
}
