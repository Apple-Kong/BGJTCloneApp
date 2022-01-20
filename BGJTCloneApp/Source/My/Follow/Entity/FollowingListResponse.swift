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
    let result: [FollowingResult]

}

struct FollowingResult: Decodable {
        let userId: Int
        let shopName: String
        let howManyItem: Int
        let howManyFollowers: Int
        let getItemResult: [GetItemResult]
}

struct GetItemResult: Decodable {
    let item_id: Int
    let price: Int
    let image_path: String
}
