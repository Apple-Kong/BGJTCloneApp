//
//  InquiryDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/19.
//

import Foundation
import Alamofire

class InquiryDataManager {
    
    var delegate: InquiryViewController?
    
    func addInquiry(itemID: Int, content: String) {
        
        let url = Constant.MAIN_URL + "/api/inquiry/\(itemID)"
        
        let parameters: Parameters = [
            "content" : content
        
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Secret.tokenHeaders)
            .responseString { response in
                switch response.result {
                case .success:
                    self.delegate?.updated()
                case .failure(let error):
                    self.delegate?.failure(message: error.localizedDescription)
                }
            }
    }
    
    func deleteInquiry(inquiryID: Int) {
        
        let url = Constant.MAIN_URL + "/api/inquiry/\(inquiryID)"
        
       
        
        AF.request(url, method: .patch,  headers: Secret.tokenHeaders)
            .responseString { response in
                switch response.result {
                case .success:
                    self.delegate?.updated()
                case .failure(let error):
                    self.delegate?.failure(message: error.localizedDescription)
                }
            }
    }
    
    func getInquiry(itemID: Int) {
        
        let url = Constant.MAIN_URL + "/api/inquiry/\(itemID)"
        
      
        
        AF.request(url, method: .get, headers: Secret.tokenHeaders)
            .responseString { response in
                print(response.value)
            }

            .responseDecodable(of: InquiryResponse.self) { response in
                switch response.result {
                case .success:
                    print(response.value)
                    self.delegate?.gotInquirys(data: response.value!.result)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.delegate?.failure(message: error.localizedDescription)
                }
            }
    }
    
}


struct InquiryResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [InquiryResult]

}


struct InquiryResult: Decodable {

    let inquiry_id: Int
    let shop_name: String
    let user_id: Int
    let content: String
    let created_at: String
}
