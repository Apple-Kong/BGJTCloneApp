//
//  DetailResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import Foundation


struct DetailResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Result]
    
    struct Result: Decodable {
        let item: Item
        let shop: Shop
        let review: Review
        
        struct Item: Decodable {
            let price: Int
            let title: String
            let safety_pay: Int
            //TIMESTAMP 오류 가능성
            let creatd_at: String
            let view: Int
            let wish_count: Int
            let condition: Int
            let delivery_fee_included: Int
            let count: Int
            let detail: String
            let images: [String]
            let tag: [Tag]
            let category_id: Int
            let inquiry_count: Int
            
            struct Tag: Decodable {
                let tag_name: String
            }
        }
        
        struct Shop: Decodable {
            let shop_name: String
            let seller_id: Int
            let follower_count: Int
            let item_count: Int
            let shop_items: [ShopItem]
            
            struct ShopItem: Decodable {
                //🚧🚧🚧이미지 패스 이름 다를 수 있음.
                let image_path: String
                
                let item_id: Int
                let price: Int
                let title: String
                
                
            }
        }
        
        
        
        struct Review: Decodable {
            let review_count: Int
            let rank_avg: String
            let reviews: [ReviewInfo]
            
            struct ReviewInfo: Decodable {
                let review_id: Int
                let rank: Int
                let content: String
                
                //오류 가능성
                let created_at: String
                
                let buyer_id: Int
                let buyer_image: Int
                let buyer_name: String
                let item_id: Int
                let item_title: String
            }
               
        }
    }
}
    
