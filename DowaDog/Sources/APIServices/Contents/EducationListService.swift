//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct EducationListService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<ContentArray<Education>>
    static let shared = EducationListService()
    let educationURL = url("/api/normal/cardnews")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 카드 뉴스 목록 조회
    func getEducationList(completion: @escaping ([Education]) -> Void) {
        
        let queryURL = educationURL + "/education"
        
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data?.content else {return}
                
                completion(data)
            case .error(let error):
                print(".error============================")
                print("error: ")
                print(error)
                print(".error============================")
            }
        }
    }
    
    // 상식 목록 조회
    func getKnowledgeList(page: Int, limit: Int, completion: @escaping ([Education]) -> Void) {
        
        let queryURL = educationURL + "/knowledge?page=\(page)&limit=\(limit)"
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data?.content else {return}
                
                completion(data)
            case .error(let error):
                print(".error============================")
                print("error: ")
                print(error)
                print(".error============================")
            }
        }
    }
    
    // 카드뉴스 교육이수 완료 등록
    func contentComplete(contentIdx: Int, completion: @escaping (ResponseObject<ContentArray<Education>>) -> Void) {
        
        let queryURL = educationURL + "/\(contentIdx)/complete"
        
        postable(queryURL, body: nil, header: headers) {
            res in
            
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
    
    // 카드뉴스 스크랩
    
    func contentScrap(contentIdx: Int, completion: @escaping (ResponseObject<ContentArray<Education>>) -> Void) {
        
        let queryURL = educationURL + "/\(contentIdx)/scrap"
        
        postable(queryURL, body: nil, header: headers) {
            res in
            
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
