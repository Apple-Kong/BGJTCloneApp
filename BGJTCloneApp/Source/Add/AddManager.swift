//
//  AddManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation
import Alamofire
import KakaoSDKTemplate


class AddManager {
    
    var delegate: AddViewController?
    
    
//    func addItem(item: ItemInfo) {
//        
//        guard let token = UserDefaults.standard.string(forKey: "jwt") else { return }
//        
//        
//        print("상품 등록 시작")
//        let urlString = Constant.MAIN_URL + "/api/items"
//        let parameters: [String: Any] = item.createParameters()
//        let headers: HTTPHeaders = [
//            "Content-Type" : "multipart/form-data",
//            "x-access-token" : token
//        ]
//       
//        
//        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .responseString { response in
//                switch response.result {
//                case .success:
//                    print(response)
//                case .failure(let error):
//                    print(error.localizedDescription)
//            }
//        }
//    }
    
    
    //MARK: - 이미지로 상품 추가 수정중...🚧🚧🚧🚧🚧
    func addItemWithImage(item: ItemInfo, images: [UIImage]) {
        
        
        guard let token = UserDefaults.standard.string(forKey: "jwt") else { return }
        let urlString = Constant.MAIN_URL + "/api/items"
        let headers: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "x-access-token" : token
        ]
        
        let parameters: Parameters = item.createImageParameters()
        
        AF.upload(multipartFormData: { multipartFormData in
            
            //이미지들 데이타로 변환해준 후에 바디에 추가
            for image in images {
       
                if let imageData = image.jpegData(compressionQuality: 0.2) {
                    multipartFormData.append(imageData, withName: "image", fileName: "\(image).jpeg", mimeType: "image/jpeg")
                }
            }
            
            //파라미터들 바디에 추가.
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                if key == "tags" {
                    for tag in value as! [String] {
                        multipartFormData.append("\(tag)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
                    }
                }
                
            }
            

      
        }, to: urlString, usingThreshold: UInt64.init(), method: .post, headers: headers)
            .responseString { response in
                switch response.result {
                case .success:
                    print("이미지를 업로드 문자열 : \(response.value)")
                case .failure(let error):
                    print("이미지를 업로드 문자열 : \(error.localizedDescription)")
            }
            
        }
            .responseDecodable(of: MainResponse.self) { response in
                switch response.result {
                case .success:
                    print("이미지를 통한 상품 업로드 : \(response.value?.code) \(response.value?.isSuccess) \(response.value?.message)")
                    self.delegate?.itemAdded()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.delegate?.failure(message: error.localizedDescription)
                }
            }
    }
}


struct MainResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message:String
}
