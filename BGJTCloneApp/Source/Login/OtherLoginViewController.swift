//
//  OtherLoginViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/10.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire

class OtherLoginViewController: UIViewController {
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    @IBAction func facebook(_ sender: UIGestureRecognizer) {
        print("wow")
    }
    
    @IBAction func naver(_ sender: UIGestureRecognizer) {
        print("naver")
        
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }

}


extension OtherLoginViewController: NaverThirdPartyLoginConnectionDelegate {
    // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
    //     let naverSignInVC = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
    //     naverSignInVC.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
    //     present(naverSignInVC, animated: false, completion: nil)

    // UPDATE: 2019. 10. 11 (금)
    // UIWebView가 제거되면서 NLoginThirdPartyOAuth20InAppBrowserViewController가 있는 헤더가 삭제되었습니다.
    // 해당 코드 없이도 로그인 화면이 잘 열리는 것을 확인했습니다.
    }
    
//    private func getNaverInfo() {
//      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
//
//      if !isValidAccessToken {
//        return
//      }
//
//      guard let tokenType = loginInstance?.tokenType else { return }
//      guard let accessToken = loginInstance?.accessToken else { return }
//      let urlStr = "https://openapi.naver.com/v1/nid/me"
//      let url = URL(string: urlStr)!
//
//      let authorization = "\(tokenType) \(accessToken)"
//
//      let req = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
//
//      req.responseJSON { response in
//        guard let result = response.result.value as? [String: Any] else { return }
//        guard let object = result["response"] as? [String: Any] else { return }
//        guard let name = object["name"] as? String else { return }
//        guard let email = object["email"] as? String else { return }
//        guard let nickname = object["nickname"] as? String else { return }
//
//        self.nameLabel.text = "\(name)"
//        self.emailLabel.text = "\(email)"
//        self.nicknameLabel.text = "\(nickname)"
//      }
//    }

    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print("[Success] : Success Naver Login")
//    getNaverInfo()
    }

    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {

    }

    // 로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
    loginInstance?.requestDeleteToken()
    }

    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    print("[Error] :", error.localizedDescription)
    }
}

