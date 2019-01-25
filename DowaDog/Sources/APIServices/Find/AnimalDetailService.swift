//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct AnimalDetailService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<DogDetail>
    static let shared = AnimalDetailService()
    let dogDetailURL = url("/api/normal/animals")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 유기동물 상세조회
    func getAnimalDetail(animalIdx: Int, completion: @escaping (DogDetail) -> Void) {
        
        let queryURL = dogDetailURL + "/\(animalIdx)"
        
        gettable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                guard let data = value.data else {return}
                
                completion(data)
            case .error(let error):
                
                print("error======================")
                print("error : ")
                print(error)
                print("error======================")
            }
        }
    }
    
    //유기동물 좋아요 
    func animalLike(animalIdx: Int, completion: @escaping (ResponseObject<DogDetail>) -> Void) {
        
        let queryURL = dogDetailURL + "/\(animalIdx)/likes"
        
        postable(queryURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                completion(value)
            case .error(let error):
                
                print("error======================")
                print("error : ")
                print(error)
                print("error======================")
            }
        }
    }
    
}
