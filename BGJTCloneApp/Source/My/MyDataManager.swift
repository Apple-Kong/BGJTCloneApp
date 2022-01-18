//
//  MyDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/18.
//

import Foundation
import Alamofire

class MyDataManager {
    
    var delegate: MyViewController?
    
    func fetch() {
        print("---- MY 페이지 요청 시작 ---")
        let url = Constant.MAIN_URL + "/api/users/myPage/\(Constant.user_ID!)"
        
        AF.request(url, method: .get, headers: Secret.tokenHeaders)
            .responseDecodable(of: MyResponse.self) { response in
                switch response.result {
                case .success:
                    self.delegate?.didFetched(data: response.value!.result)
                    print("My page 요청 : \(response.value!)")
                case.failure(let error):
                    self.delegate?.failure(message: error.localizedDescription)
                    print("\(error.localizedDescription)")
                }
            }
    }
}

