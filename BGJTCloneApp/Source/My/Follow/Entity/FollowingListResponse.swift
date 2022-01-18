//
//  FollowingListResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import Foundation


struct FollowingListResponse: Decodable {
    
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FollowerResult]
    
    struct FollowerResult: Decodable {
        let userId: Int
        let shopName: String
        let howManyFollowers: Int
        let getItemResult: [ItemResult]
        
        struct ItemResult: Decodable {
            let item_id: Int
            let price: Int
            let image_path: String
        }
    }
}


