//
//  RecommendDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation
import Alamofire


class RecommendDataManager {
    
    var delegate: RecommendDelegate?
    
    func fetchData(page: Int) {
        print("추천 상품 네트워킹 시작")
        
        let urlString = Constant.MAIN_URL + "/api/items/main"
        let headers = Secret.tokenHeaders
        
        AF.request(urlString, method: .get, headers: headers)
            .responseString(completionHandler: { response in
                print(response.value)
            })
            .responseDecodable(of: RecommendResponse.self) { response in
                switch response.result {
                case .success:
                    print("추천 상품 목록 : \(response.value?.message ?? "no message" )")
                    self.delegate?.didFetchedData(items: response.value?.result)
                    
                
                case .failure(let error):
                    print("추천 상품 목록 : \(error.localizedDescription)")
                }
            }
    }
}

protocol RecommendDelegate {
    func didFetchedData(items: [RecommendResponse.Result]?)
}
