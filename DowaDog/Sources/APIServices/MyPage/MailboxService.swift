//
//  LoginService.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import Alamofire

struct MailboxService: APIManager, Requestable {
    
    typealias NetworkData = ResponseArray<Mailbox>
    static let shared = MailboxService()
    let myMailboxURL = url("/api/normal/mypage/mailboxes")
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]
    
    // 마이페이지 조회
    func getMailbox(completion: @escaping ([Mailbox]) -> Void) {
        
        gettable(myMailboxURL, body: nil, header: headers) { res in
            switch res {
            case .success(let value):
                
                print(".success=========================")
                print("value: ")
                print(value)
                print(".success=========================")
                
                
                guard let data = value.data else { return }
                
                completion(data)
            case .error(let error):
                print(".error============================")
                print("error: ")
                print(error)
                print(".error============================")
            }
        }
    }
    
    func readMailbox(completion: @escaping (ResponseArray<Mailbox>) -> Void) {
        
        let queryURL = myMailboxURL + "/readings"
        
        gettable(queryURL, body: nil, header: headers) { res in
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
