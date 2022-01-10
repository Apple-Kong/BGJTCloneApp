//
//  NaverLoginResponse.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/10.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let naverLoginResponse = try? newJSONDecoder().decode(NaverLoginResponse.self, from: jsonData)

import Foundation

// MARK: - NaverLoginResponse
struct NaverLoginResponse: Decodable {
    let resultcode: String?
    let message: String?
    let response: Response?
  }

struct Response: Decodable {
    let email: String?
    let nickname: String?
    let profile_image: String?
    let age: String?
    let gender: String?
    let id: String?
    let name: String?
    let birthday: String?
    let birthyear: String?
    let mobile: String?
}


