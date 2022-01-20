//
//  RecommendResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation

struct RecommendResponse: Decodable {
    
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Result]
       
    struct Result: Decodable {
        let item_id: Int
        let title: String
        let price: Int
        let safety_pay: Int
        let location: String?
        let created_at: String
        let image_path: String
        let wish_count: Int
    }
}


