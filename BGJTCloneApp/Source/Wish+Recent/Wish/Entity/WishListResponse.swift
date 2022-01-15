//
//  WishListResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation

struct WishListResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Result]
    
    struct Result: Decodable {
        let item_id: Int
        let image_path: String
        let safety_pay: Int
        let title: String
        let price: Int
        let created_at: String
        let shop_name: String
        let shop_image: String?
    }
}
