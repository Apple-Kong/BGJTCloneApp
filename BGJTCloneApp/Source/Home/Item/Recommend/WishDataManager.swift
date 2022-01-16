//
//  WishDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation
import Alamofire

class WishDataManager {
    
    
    
    func addWishItem(itemID: Int) {
        
        let urlString = Constant.MAIN_URL + "/api/wishes/\(itemID)"
        let headers = Secret.tokenHeaders
        //패스 배리블로 인코딩.
        
        AF.request(urlString, method: .post, headers: headers)
            
            .responseDecodable(of: WishResponse.self) { response in
                switch response.result {
                case .success:
                    print("찜 목록 추가 : \(response.value?.message ?? "no message" )")
                case .failure(let error):
                    print("찜 목록 추가 : \(error.localizedDescription)")
                }
            }
    }
    
    func deleteWishItem(itemID: Int) {
        print("-------찜 목록 삭제 요청 시작 ----------")
        let urlString = Constant.MAIN_URL + "/api/wishes/\(itemID)"
        let headers = Secret.tokenHeaders
        
        
        AF.request(urlString, method: .patch, headers: headers)
            .responseString(completionHandler: { response in
                print(response.value)
            })
            .responseDecodable(of: WishResponse.self) { response in
                switch response.result {
                case .success:
                    print("찜 목록 삭제 : \(response.value?.message ?? "no message" )")
                case .failure(let error):
                    print("찜 목록 삭제 : \(error.localizedDescription)")
                }
            }
    }
}
