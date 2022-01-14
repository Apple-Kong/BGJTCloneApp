//
//  AddManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation
import Alamofire


class AddManager {
    func addItem(item: ItemInfo) {
        
        guard let token = UserDefaults.standard.string(forKey: "jwt") else { return }
        
        
        print("상품 등록 시작")
        let urlString = Constant.MAIN_URL + "/api/items"
        let parameters: [String: Any] = item.createParameters()
        let headers: HTTPHeaders = ["x-access-token" : token]
       
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseString { response in
                switch response.result {
                case .success:
                    print(response)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
