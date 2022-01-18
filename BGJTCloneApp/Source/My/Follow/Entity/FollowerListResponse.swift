//
//  FollowerListResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import Foundation



struct FollowerListResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FollowResult]
    
    struct FollowResult: Decodable {
        let item_id: Int
        let image_path: String
        let safety_pay: Int
        let title: String
        let price: Int
        let created_at: String
        let shop_name: String
    }
}
