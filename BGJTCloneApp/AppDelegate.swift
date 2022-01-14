//
//  AppDelegate.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/08.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import NaverThirdPartyLogin
import Alamofire


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
          return AuthController.handleOpenUrl(url: url)
        }
       return false
       }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        // 네이버 앱으로 인증하는 방식을 활성화
        instance?.isNaverAppOauthEnable = true
        
        // SafariViewController에서 인증하는 방식을 활성화
        instance?.isInAppOauthEnable = true
        
        // 인증 화면을 iPhone의 세로 모드에서만 사용하기
        instance?.isOnlyPortraitSupportedInIphone()
        
        // 네이버 아이디로 로그인하기 설정
        // 애플리케이션을 등록할 때 입력한 URL Scheme
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        // 애플리케이션 등록 후 발급받은 클라이언트 아이디
        instance?.consumerKey = kConsumerKey
        // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
        instance?.consumerSecret = kConsumerSecret
        // 애플리케이션 이름
        instance?.appName = kServiceAppName
        
        KakaoSDK.initSDK(appKey: Secret.KAKAO_KEY)
        
        
        
        // 앱 토큰 불러오기
        if let token = UserDefaults.standard.string(forKey: "jwt") {
            
            print("토큰 존재")
            
            //토큰으로 자동 로그인 요청
            let headers: HTTPHeaders = [
                "x-access-token": token
            ]
            
            let urlString = Constant.MAIN_URL + "/api/auth/auto-login"
            
            AF.request(urlString, method: .get, parameters: nil, headers: headers)
                .responseDecodable(of: AutoLoginResponse.self) { response in
                    switch response.result {
                    case .success:
                        print(response.value?.message)
                        UserDefaults.standard.set(true, forKey: "isLogin")
                    case .failure(let error):
                        print(error.localizedDescription)
                        UserDefaults.standard.set(false, forKey: "isLogin")
                    }
                }
            
                //성공 >> 앱 진입
            
                //실패 >> 소셜 로그인 정보 불러오기.
                        
                        //소셜 정보 확인
                            
                            //유 >> 로그인 시도
                                
                                //성공
            
            
                                //실패
            
                                    //회원가입 뷰
                            //무 >> 회원가입 뷰
            
        } else {
            
            print("토큰 X")
            
            UserDefaults.standard.set(false, forKey: "isLogin")
                                      //)
            
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

