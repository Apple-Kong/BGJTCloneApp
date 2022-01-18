//
//  FollowDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import Foundation
import Alamofire

class FollowDataManager {
    func followShop(shopID: Int) {
        
        let url = Constant.MAIN_URL + "/api/follow/users/\(Constant.user_ID!)"
        let parameters : Parameters = [
            "follow" : shopID
        ]
        
        print(shopID)
        AF.request(url, method: .post, parameters: parameters, headers: Secret.tokenHeaders)
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success:
                    print("상점 팔로우 : \(response.value?.message) code: \(response.value?.code)")
                case .failure(let error):
                    print("상점 팔로우 실패 : \(error.localizedDescription)")
                }
            }
    }
    
    func unFollowShop(shopID: Int) {
        let url = Constant.MAIN_URL + "/api/follow/users/\(Constant.user_ID!)"
        let parameters : Parameters = [
            "delete" : shopID
        ]
       
        AF.request(url, method: .patch, parameters: parameters, headers: Secret.tokenHeaders)
            .responseString(completionHandler: { response in
                print(response.value)
            })
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success:
                    print("상점 팔로우 : \(response.value?.message) code: \(response.value?.code)")
                case .failure(let error):
                    print("상점 팔로우 실패 : \(error.localizedDescription)")
                }
            }
    }
}
