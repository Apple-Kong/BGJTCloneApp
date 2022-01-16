//
//  AccountDataManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import Foundation
import Alamofire




class AccountDataManager {
    
    var deleagate: AccountDelegate?
    
    static let shared = AccountDataManager()
    
    var accounts: [AccountResponse.Result] = []
    
    func getAccount() {
        print("--------계좌 조회 시작---------")
        guard let tokenHeaders = Secret.tokenHeaders else { return }
        
        let url = Constant.MAIN_URL + "/api/users/account/\(Constant.user_ID!)"
        
        AF.request(url, method: .get, headers: tokenHeaders)
            .responseString { response in
                print(response.value)
            }
            .responseDecodable(of: AccountResponse.self) { response in
                switch response.result {
                case .success:
                    
                    if let value = response.value {
                        if value.isSuccess {
                            self.accounts = value.result
                        }
                    }
                    
                    self.deleagate?.accountUpdated()
                case .failure(let error):
                    print("계좌 조회 :  \(error.localizedDescription)")
                }
            }
    }
    
    func addAccount(name: String, bankName: String, accNum: String) {
        
        print("--------계좌등록 시작---------")
        
        guard let tokenHeaders = Secret.tokenHeaders else { return }
        
        let url = Constant.MAIN_URL + "/api/users/account/\(Constant.user_ID!)"
        
        let parmeters: Parameters = [
            "name" : name,
            "bank" : bankName,
            "account_num" : accNum
        ]
        
        AF.request(url, method: .post, parameters: parmeters, encoding: JSONEncoding.default, headers: tokenHeaders)
            .responseString { response in
                print(response.value)
            }
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success:
                    response.value?.printResponse(message: "계좌 등록")
                    
                    self.deleagate?.accountUpdated()
                case .failure(let error):
                    print("계좌 등록 :  \(error.localizedDescription)")
                }
            }
    }
    
    func editAccount(changeAccountNum: String, name: String, bank: String, account_num: String, for_sale: Bool, for_return: Bool) {
        
        print("--------계좌수정 시작---------")
        guard let tokenHeaders = Secret.tokenHeaders else { return }
        
        let url = Constant.MAIN_URL + "/api/users/account/\(Constant.user_ID!)"
        
        let parmeters: Parameters = [
            "changeAccountNum" : changeAccountNum,
            "name" : name,
            "bank" : bank,
            "account_num" : account_num,
            "for_sale" : for_sale ? 1 : 0,
            "for_return" : for_return ? 1 : 0
        ]
        
        AF.request(url, method: .put, parameters: parmeters, encoding: JSONEncoding.default, headers: tokenHeaders)
            .responseString { response in
                print(response.value)
            }
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success:
                    response.value?.printResponse(message: "계좌수정")
                    self.deleagate?.accountUpdated()
                case .failure(let error):
                    print("계좌 수정 :  \(error.localizedDescription)")
                }
            }
    }
    
    func deleteAccount(account_num: String) {
        
        print("--------계좌삭제 시작---------")
        
        guard let tokenHeaders = Secret.tokenHeaders else { return }
        let url = Constant.MAIN_URL + "/api/users/account/\(Constant.user_ID!)"
        
        let parameters: Parameters = [
            "account_num" : account_num
        ]
        
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: tokenHeaders)
            .responseString { response in
                print(response.value)
            }
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success:
                    response.value?.printResponse(message: "계좌 삭제")
                   
                case .failure(let error):
                    print("계좌 삭제 :  \(error.localizedDescription)")
                }
            }
        
    }
}

protocol AccountDelegate {
    func accountUpdated()
}

