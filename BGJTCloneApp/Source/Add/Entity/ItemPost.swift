//
//  ItemPost.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation

struct itemInfo {
    let category_id: Int
    let title: String
    let location: String?
    let price: Int
    let delivery_fee_included: Int
    let count: Int
    let condition: Int
    let exchange: Int
    let detail: String
    let safety_pay: Int
    let tags: [String]
    let images: [String]
}
