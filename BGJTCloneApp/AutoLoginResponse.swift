//
//  AutoLoginResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/11.
//

import Foundation


struct AutoLoginResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
