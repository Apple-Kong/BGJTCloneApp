//
//  ItemPost.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation

struct ItemInfo {
    let category: [String]
    let title: String
    let location: String?
    let price: Int
    let delivery_fee_included: Bool
    let count: Int
    let isOld: Bool
    let isExchangable: Bool
    let detail: String
    let isSafe: Bool
    let tags: [String]
    let images: [String]
    
    
    
    func arrayEncoding(name: String, array: [String]) -> [[String: String]] {
        
        var result: [[String: String]] = []
        for item in array {
            result.append([name : item])
        }
        return result
    }
    
    func createParameters() -> [String: Any] {
        let parameters: [String: Any] = [
            "category_id" : mapCategory(),
            "title" : title,
            "location" : location ?? "",
            "price" : price,
            "delivery_fee_included" : self.delivery_fee_included ? 1 : 0,
            "count" : count,
            "condition" : isOld ? 0 : 1,
            "exchange" : isExchangable ? 1 : 0,
            "detail" : detail,
            "safety_pay" : isSafe ? 1 : 0,
            "tags" : arrayEncoding(name: "tag", array: tags),
            "images" : arrayEncoding(name: "image", array: images)
        ]
        
        return parameters
    }
    
    
    func mapCategory() -> Int {
        var categoryID = 0
        
        if category.count > 1 {
            switch category.first {
            case "여성의류":
                switch category.last {
                case "패딩/점퍼":
                    categoryID = 10
                case "코트":
                    categoryID = 11
                case "맨투맨":
                    categoryID = 12
                case "후드티/후드집업":
                    categoryID = 13
                case "티셔츠":
                    categoryID = 14
                case "블라우스":
                    categoryID = 15
                default:
                    categoryID = 0
                }
            case "남성의류":
                switch category.last {
                case "패딩/점퍼":
                    categoryID = 20
                case "코트":
                    categoryID = 21
                case "맨투맨":
                    categoryID = 22
                case "후드티/후드집업":
                    categoryID = 23
                case "티셔츠":
                    categoryID = 24
                case "셔츠":
                    categoryID = 25
                default:
                    categoryID = 0
                }
            case "신발":
                switch category.last {
                case "스니커즈":
                    categoryID = 30
                case "남성화":
                    categoryID = 31
                case "여성화":
                    categoryID = 32
                default:
                    categoryID = 0
                }
            case "가방":
                switch category.last {
                case "여성가방":
                    categoryID = 40
                case "남성가방":
                    categoryID = 41
                case "여행용":
                    categoryID = 42
                default:
                    categoryID = 0
                }
            case "시계/쥬얼리":
                
                switch category.last {
                case "시계":
                    categoryID = 50
                case "쥬얼리":
                    categoryID = 51
                default:
                    categoryID = 0
                }
            case "패션 액세서리":
                switch category.last {
                case "지갑":
                    categoryID = 60
                case "벨트":
                    categoryID = 61
                case "모자":
                    categoryID = 62
                case "목도리/장갑":
                    categoryID = 63
                case "스카프/넥타이":
                    categoryID = 64
                case "안경/선글라스":
                    categoryID = 65
                default:
                    categoryID = 0
                }
            case "디지털/가전":
                switch category.last {
                case "모바일":
                    categoryID = 70
                case "가전제품":
                    categoryID = 71
                case "오디오/영상/관련기기":
                    categoryID = 72
                case "PC/노트북":
                    categoryID = 73
                case "게임/타이틀":
                    categoryID = 74
                case "카메라/DSLR":
                    categoryID = 75
                default:
                    categoryID = 0
                }
            case "스포츠/레저":
                switch category.last {
                case "골프":
                    categoryID = 20
                case "캠핑":
                    categoryID = 21
                case "낚시":
                    categoryID = 22
                case "축구":
                    categoryID = 23
                case "자전거":
                    categoryID = 24
                case "인라인/스케이트보드":
                    categoryID = 25
                default:
                    categoryID = 0
                }
            default:
                categoryID = 0
            }
        } else {
            print("카테고리 오류 : 카테고리 길이 2개 미만")
        }
        
        if categoryID == 0 {
            print("카테고리 해당 없음.")
            return 0
        } else {
            return categoryID
        }
        
    }

}
