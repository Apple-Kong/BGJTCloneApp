//
//  AccountResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import Foundation

struct AccountResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Result]
    
    struct Result: Decodable {
        let account_number: String
        let bank: String
        let user_name: String
        let for_sale: Int
        let for_return: Int
    }
}


struct DefaultResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    
    func printResponse(message: String) {
        print("-----------------")
        print("\(message) 에 대한 응답")
        print("\(self.isSuccess)")
        print("\(self.code)")
        print("\(self.message)")
        print("-----------------")
    }
}
