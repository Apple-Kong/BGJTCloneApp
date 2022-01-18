//
//  DealDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import Foundation
import Alamofire

class DealDataManager {
    func deal(itemID: Int, deal_type: Int, address: String, pay: String) {
        
        
        let url = Constant.MAIN_URL + "/api/deal/\(itemID)"
        let tokenHeaders = Secret.tokenHeaders
        
        let parameters: Parameters = [
            "deal_type": deal_type,
            "address": address,
            "pay": pay
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: tokenHeaders)
            .responseString { response in
                print("\(response.value)")
            }
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success:
                    print("결제 하기 성공 : \(response.value?.message)")
                case .failure(let error):
                    print("결제 하기 실패 : \(error.localizedDescription)")
                }
            }
    }
    
}


