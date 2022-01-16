//
//  DetailDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import Foundation
import Alamofire

class DetailDataManager {
    
    
    var delegate: DetailDelegate?
    
    
    func fetch(itemID: Int) {
        print("---- 상품 상세페이지 요청 시작 ----")
        
        
        let urlString = Constant.MAIN_URL + "/api/items/\(itemID)"
        
        AF.request(urlString, method: .get, headers: Secret.tokenHeaders)
            .responseString(completionHandler: { response in
                print(response.value)
            })
            .responseDecodable(of: DetailResponse.self) { response in
                switch response.result {
                case .success:
                    if let value = response.value?.result[0] {
                        print("---- 상품 상세페이지 요청 성공 ----")
                        self.delegate?.itemFetched(item: value.item, shop: value.shop, review: value.review)
                        
                    } else {
                        self.delegate?.failure(message: response.value?.message ?? " no message ")
                    }
                    
                case .failure(let error):
                    print("---- 상품 상세 페이지 실패 : \(error.localizedDescription)")
                    self.delegate?.failure(message: error.localizedDescription)
                }
            }
    }
}

protocol DetailDelegate {
    func itemFetched(item: DetailResponse.Result.Item, shop: DetailResponse.Result.Shop, review: DetailResponse.Result.Review)
    
    func failure(message: String)
}



    
 
