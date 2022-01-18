//
//  MyResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/18.
//

import Foundation


struct MyResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MyResult
    
    struct MyResult: Decodable {
        let user_image: String?
        let shop_name: String
        let user_rank: Float?
        let wish_count: Int
        let review_count: Int
        let following_count: Int
        let follower_count: Int
    }
}
