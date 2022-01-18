//
//  DetailResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import Foundation



// MARK: - DetailResponse2
struct DetailResponse2: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let item: Item
    let shop: Shop
    let review: ResultReview
}

// MARK: - Item
struct Item: Codable {
    let price: Int
    let title: String
    let safetyPay: Int
    let creatdAt: String
    let view, wishCount, condition, deliveryFeeIncluded: Int
    let location: String?
    let count: Int
    let detail: String
    let images: [Image]
    let tags: [Tag]
    let categoryID, inquiryCount: Int

    enum CodingKeys: String, CodingKey {
        case price, title
        case safetyPay = "safety_pay"
        case creatdAt = "creatd_at"
        case view
        case wishCount = "wish_count"
        case location
        case condition
        case deliveryFeeIncluded = "delivery_fee_included"
        case count, detail, images, tags
        case categoryID = "category_id"
        case inquiryCount = "inquiry_count"
    }
}

// MARK: - Image
struct Image: Codable {
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case imagePath = "image_path"
    }
}

// MARK: - Tag
struct Tag: Codable {
    let tagName: String

    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
    }
}

// MARK: - ResultReview
struct ResultReview: Codable {
    let reviewCount: Int?
    let rankAvg: String?
    let reviews: [ReviewElement]

    enum CodingKeys: String, CodingKey {
        case reviewCount = "review_count"
        case rankAvg = "rank_avg"
        case reviews
    }
}

// MARK: - ReviewElement
struct ReviewElement: Codable {
    let reviewID, rank: Int
    let content, createdAt: String
    let buyerID: Int
    
    //오류시 buyerImage >> JSONNull? 로 바꿀것.
    let buyerImage: String?
    let buyerName: String
    let itemID: Int
    let itemTitle: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case rank, content
        case createdAt = "created_at"
        case buyerID = "buyer_id"
        case buyerImage = "buyer_image"
        case buyerName = "buyer_name"
        case itemID = "item_id"
        case itemTitle = "item_title"
    }
}

// MARK: - Shop
struct Shop: Codable {
    let shopName: String
    let sellerID, followerCount, itemCount: Int
    let shopItems: [ShopItem]

    enum CodingKeys: String, CodingKey {
        case shopName = "shop_name"
        case sellerID = "seller_id"
        case followerCount = "follower_count"
        case itemCount = "item_count"
        case shopItems = "shop_items"
    }
}

// MARK: - ShopItem
struct ShopItem: Codable {
    let itemID, price: Int
    let title: String
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case price, title
        case imagePath = "image_path"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


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
            let images: [ImagePath]
            
            struct ImagePath: Decodable {
                let image_path: String
            }
            
            let tags: [Tag]
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
                let buyer_image: String?
                let buyer_name: String
                let item_id: Int
                let item_title: String
            }
               
        }
    }
}
    
