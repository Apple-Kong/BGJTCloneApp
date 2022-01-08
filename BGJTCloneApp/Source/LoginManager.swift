//
//  LoginManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/08.
//

import Alamofire
import KakaoSDKAuth
import KakaoSDKUser

class LoginManager {
    func kakaoLogin(delegate: LoginViewController) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    
                    delegate.loginFailure()
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                    
                    delegate.didLogin()
                }
            }
    }
}
