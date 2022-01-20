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
    let result: FollowResult
    
    struct FollowResult: Decodable {
        let followerInfo: [FollowerInfo]
        
    }
}

struct FollowerInfo: Decodable {
    let user_id: Int
    let shop_name: String
    let image: String?
    let countItem: Int
    let countFollower: Int
}
