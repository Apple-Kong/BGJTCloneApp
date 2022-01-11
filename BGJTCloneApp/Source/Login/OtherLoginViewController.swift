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
    let loginManager = LoginManager()
    
    var dismissDelegate: DismissDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginManager.delegate = self
    }
    
    
    @IBAction func facebook(_ sender: UIGestureRecognizer) {
     
    }
    
    @IBAction func naver(_ sender: UIGestureRecognizer) {
  
        loginManager.naverLogin()

    }
}

protocol DismissDelegate {
    func dismiss()
}


//MARK: - 로그인 매니져 delegate 함수 호출
extension OtherLoginViewController: LoginDelegate {
    
    func didSignUp(loginInfo: LoginInfo) {
        self.loginManager.signUp(loginInfo: loginInfo)
    }
    
    func didLogin() {
        self.dismiss(animated: true) {
            //히위 뷰컨트롤러 까지 디스미스 시키기! [✅]
            self.dismissDelegate?.dismiss()
        }
    }
    
    func loginFailed(message: String?) {
        self.presentAlert(title: "로그인 실패", message: message)
    }
}

