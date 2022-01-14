//
//  WishListDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation
import Alamofire

protocol WishListDelegate {
    func didFetch(items: [WishListResponse.Result])
    func failure(message: String)
}

class WishListDataManager {
    
    var delegate: WishListDelegate?
    
    func fetchData() {
        
        
        let urlString = Constant.MAIN_URL + "/api/wishes"
        
    
        AF.request(urlString, method: .get, headers: Secret.tokenHeaders)
            .responseString { response in
                print("찜 목록 : \(response.value ?? "")")
            }
            .responseDecodable(of: WishListResponse.self ) { response in
                switch response.result {
                case .success:
                    print("찜 목록 : \(response.value)")
                    if let items = response.value?.result {
                        self.delegate?.didFetch(items: items)
                    } else {
                        self.delegate?.failure(message: response.value?.message ?? "no message")
                    }
                    
                case .failure(let error):
                    print("찜 목록 : \(error.localizedDescription)")
                    self.delegate?.failure(message: error.localizedDescription)

                }
            }
    }
}
