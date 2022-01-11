//
//  LoginManager.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/08.
//

import Alamofire
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Metal


struct LoginInfo: Encodable {
    let social_id: String
    let name: String
    let social_info: String
    let shop_name: String
}


protocol LoginDelegate {
    func didSignUp(loginInfo: LoginInfo)
    func didLogin()
    func loginFailed(message: String?)
}

class LoginManager: NSObject {
    
    
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    
    var delegate: LoginDelegate?
    
    override init() {
        super.init()
        //네이머 로그인 delegate 설정
        loginInstance?.delegate = self
        
    }
    
    init(delegate: LoginDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    
    // MARK: - 카카오 로그인
    //카카오로 로그인하기
    func kakaoLogin() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
                
                self.delegate?.loginFailed(message: error.localizedDescription)
            }
            else {
                print("loginWithKakaoAccount() success.")
                //do something
                _ = oauthToken
                
                self.delegate?.didLogin()
            }
        }
    }
    
    //카카오 회원정보 조회 요청
    
    // MARK: - 네이버 로그인
    //네이버로 로그인하기
    func naverLogin() {
        loginInstance?.requestThirdPartyLogin()
    }
    
    //네이버 사용자 정보 불러오기
    private func getNaverInfo() {
        
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        //토큰이 유효하지 않다면 실행 되는 코드 블럭
        if !isValidAccessToken {
          return
        }
        
        //헤더 생성 ( 토큰 정보 삽입 )
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        let authorization = "\(tokenType) \(accessToken)"
        let header: HTTPHeaders = ["Authorization" : authorization]
        
        
        AF.request(Constant.NAVER_USER_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: NaverLoginResponse.self ) { response in
                switch response.result {
                case .success:
                    print("네이버 사용자 정보 요청 success")
                    
                    let data = response.value?.response
                    print(data)
                    if let id = data?.id, let name = data?.name, let nickName = data?.nickname {
                        let logInfo = LoginInfo(social_id: id, name: name, social_info: "Naver", shop_name: nickName)
                        
                        if let delegate = self.delegate {
                            delegate.didSignUp(loginInfo: logInfo)
                        } else {
                            print("delegate 존재하지 X")
                        }
                        
                    } else {
                        print("회원가입 정보 불충분")
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    print("ohoh")
                    
                    self.delegate?.loginFailed(message: error.localizedDescription)
                }
            }
      }
}


//MARK: - 메인 서버 로그인
extension LoginManager {
    
    //MARK: - 메인 서버 회원가입
    func signUp(loginInfo: LoginInfo) {
        
        print("회원가입 통신 시작 ")
        let urlString = Constant.MAIN_URL + "/api/users"
        
        let parameters: [String: String] = [
            "social_id" : loginInfo.social_id,
            "name" : loginInfo.name,
            "social_info" : loginInfo.social_info,
            "shop_name" : loginInfo.shop_name
        ]
        
       
    
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString { response in
                switch response.result {
                case .success:
                    
                    
                    //🚧👷🏻‍♂️🛠중복된 소셜아이디 이면??? [ ] 에러 핸들링 해줄 것.
                    self.login(loginInfo: loginInfo)
                    
                    //🚧👷🏻‍♂️🛠 그외 회원가입 실패??? 핸들링 [ ]
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    self.delegate?.loginFailed(message: error.localizedDescription)
                }
            }
    }
    
    
    
    func login(loginInfo: LoginInfo) {
        print("로그인 통신 시작")
        
        let urlString = Constant.MAIN_URL + "/api/auth/login"
        
        let parameters: [String: String] = [
            "social_id" : loginInfo.social_id,
            "name" : loginInfo.name,
            "social_info" : loginInfo.social_info
        ]
    
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: LoginResponse.self ){ response in
                switch response.result {
                case .success:
                
                    if response.value?.isSuccess ?? false {
                        UserDefaults.standard.set(response.value?.result.user_id, forKey: "user_id")
                        UserDefaults.standard.set(response.value?.result.jwt, forKey: "jwt")
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        self.delegate?.didLogin()
                    } else {
                        // 예외처리
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    self.delegate?.loginFailed(message: error.localizedDescription)
                }
            }
    }
}

struct LoginResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
    
    struct Result: Decodable {
        let user_id: Int
        let jwt: String
    }
}



// MARK: - 네이버 delegate 함수들

extension LoginManager: NaverThirdPartyLoginConnectionDelegate {
    // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
    //     let naverSignInVC = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
    //     naverSignInVC.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
    //     present(naverSignInVC, animated: false, completion: nil)

    // UPDATE: 2019. 10. 11 (금)
    // UIWebView가 제거되면서 NLoginThirdPartyOAuth20InAppBrowserViewController가 있는 헤더가 삭제되었습니다.
    // 해당 코드 없이도 로그인 화면이 잘 열리는 것을 확인했습니다.
    }
    

    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        getNaverInfo()
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
        
        self.delegate?.loginFailed(message: error.localizedDescription)
    }
}
