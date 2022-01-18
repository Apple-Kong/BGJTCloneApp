//
//  ItemEditManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/18.
//

import Foundation
import Alamofire

class ItemEditManager {
    
    func edit(itemID: Int) {
        //MARK: - 서버 API 수정 안되어있음 엮지 말것.
//        let url = Constant.MAIN_URL + "/api/items/\(itemID)"
//
//        AF.request(url, method: .put, headers: Secret.tokenHeaders)
//            .responseDecodable(of: DefaultResponse.self) { response in
//                switch response.result {
//                case .success:
//                    print(response.value)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
    }
    
    
    func delete(itemID: Int) {
        
        print("=========상품 삭제 요청 시작 ========")
        let url = Constant.MAIN_URL + "/api/items/\(itemID)"
        
        AF.request(url, method: .patch, headers: Secret.tokenHeaders)
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success:
                    print(response.value)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    // Status : Sale // Reserved // Sold
    func changeCondition(itemID: Int, statusNum: Int) {
        
        print("=========상품 상태 변경 요청 시작 ========")
        var status = ""
        switch statusNum {
        case 1:
            status = "Sale"
        case 2:
            status = "Reserved"
        case 3:
            status = "Sold"
        default:
            status = "Sale"
        }
        
        let url = Constant.MAIN_URL + "/api/items/\(itemID)/sales/\(status)"
        
        print(url)
        
        AF.request(url, method: .patch, headers: Secret.tokenHeaders)
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success:
                    print(response.value)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}


