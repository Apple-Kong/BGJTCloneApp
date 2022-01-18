//
//  DealListDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/18.
//

import Foundation
import Alamofire

class DealListDataManager {
    
    var buyDelegate: BuyListDelegate?
    var sellDelegate: SellListDelegate?
    
    
    
    func fetchBuyList() {
        print("=== 구매 내역 요청 시작 ===")
        let url = Constant.MAIN_URL + "/api/deal/buyer"
        
        AF.request(url, method: .get, headers: Secret.tokenHeaders)
            .responseString { response in
                print(response.value!)
            }
            .responseDecodable(of: BuyListResponse.self) { response in
                switch response.result {
                case . success:
                    print("구매내역 : \(response.value)")
                    
                    self.buyDelegate?.didFetched(data: response.value!.result)
                case .failure(let error):
                    print("구매내역 : \(error.localizedDescription)")
                }
            }
    }
    
    func fetchSellList() {
        
        print("=== 판매 내역 요청 시작 ===")
        let url = Constant.MAIN_URL + "/api/deal/seller"
        
        AF.request(url, method: .get, headers: Secret.tokenHeaders)
            .responseString { response in
                print(response.value!)
            }
            .responseDecodable(of: SellListResponse.self) { response in
                switch response.result {
                case . success:
                    print("판매 내역 : \(response.value)")
                    self.sellDelegate?.didFetched(data: response.value!.result)
                case .failure(let error):
                    print("판매 내역 : \(error.localizedDescription)")
                }
            }
    }
}

struct BuyListResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [BuyListResult]
    
    
}

struct BuyListResult: Decodable {
    let deal_id: Int
    let seller_id: Int
    let created_at: String
    let process: String
    let title: String
    let price: Int
    let safety_pay: Int
    let image_path: String?
}

struct SellListResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [SellListResult]
}

struct SellListResult: Decodable {
    let item_id: Int//
    let created_at: String//
    let sale: String
    let title: String//
    let price: Int//
    let safety_pay: Int//
    let image_path: String?//
}



protocol BuyListDelegate {
    func didFetched(data: [BuyListResult])
    func failure(message: String)
}

protocol SellListDelegate {
    func didFetched(data: [SellListResult])
    func sellListFailure(message: String)
}
