//
//  EmergeDogService.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct AdoptService: APIManager, Requestable{
    typealias NetworkData = ResponseBool
    static let shared = AdoptService()
    let AdoptURL = url("/api/normal/registrations")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? "",
        "Content-Type": "application/json"
    ]
    
    // offline 신청
    
    func requestOffline(animalIdx: Int, completion: @escaping (ResponseBool) -> Void) {
        
        let queryURL = AdoptURL + "/offline"
        
        let body = [
            "animalId": animalIdx
        ]
        
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
    
    func requestOnline(animalIdx: Int, phone: String, email: String, address: String, job: String, havePet: Bool, regType: String, petInfo: String, adoptType: String, completion: @escaping (ResponseBool) -> Void) {
        
        let queryURL = AdoptURL + "/online"
    
        let body: [String: Any] = [
            "phone": phone,
            "email": email,
            "address": address,
            "job": job,
            "havePet": havePet,
            "regType": regType,
            "petInfo": petInfo,
            "adoptType": adoptType,
            "animalId": animalIdx
        ]
        
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
