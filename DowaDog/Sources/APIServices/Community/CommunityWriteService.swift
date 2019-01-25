import Alamofire

struct CommunityWriteService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<CommunityWrite>
    static let shared = CommunityWriteService()
    let communityURL = url("/api/normal/community")
    let headers: HTTPHeaders = [
        "Content-Type": "multipart/form-data",
        "Authorization": UserDefaults.standard.string(forKey: "Token") ?? ""
    ]

    
    func writeCommunityWrite(title: String, detail: String, communityImgFiles: Array<UIImage>, completion: @escaping (ResponseObject<CommunityWrite>) -> Void) {
        
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(title.data(using: .utf8)!, withName: "title")
            multipart.append(detail.data(using: .utf8)!, withName: "detail")
            for i in 0..<communityImgFiles.count {
                multipart.append(communityImgFiles[i].jpegData(compressionQuality: 0.5)!, withName: "communityImgFiles", fileName: "image\(i).jpeg", mimeType: "image/jpeg")
            }
        }, to: communityURL, method: .post, headers: headers) {
            (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseObject { (res: DataResponse<ResponseObject<CommunityWrite>>) in
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








