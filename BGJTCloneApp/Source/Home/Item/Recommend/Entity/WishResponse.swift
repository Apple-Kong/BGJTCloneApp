//
//  WishResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import Foundation

struct WishResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}


