//
//  Constant.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import Foundation



struct Constant {
    static let NAVER_USER_URL = "https://openapi.naver.com/v1/nid/me"
    
    static let MAIN_URL = "https://dev.bjclone.shop"
    
    
    static var user_ID: String? {
        return UserDefaults.standard.string(forKey: "user_id")
    }
    
    //UserDefault key 들
    
    /*
     jwt : 토큰
     user_id : 사용자 ID
     
     */
}
