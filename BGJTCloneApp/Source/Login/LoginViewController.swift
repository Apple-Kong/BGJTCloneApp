//
//  LoginViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/08.
//

import UIKit
import ImageSlideshow
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    let loginManager = LoginManager()

    //이미지 슬라이드
    @IBOutlet weak var slideShow: ImageSlideshow!
    let images = [
        ImageSource(image: UIImage(named: "Login_1")!),
        ImageSource(image: UIImage(named: "Login_2")!),
        ImageSource(image: UIImage(named: "Login_3")!),
        ImageSource(image: UIImage(named: "Login_4")!)
        ]

    
    @IBOutlet weak var kakaoButton: UIButton!
    
    @IBAction func appleLoginButton(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
    
    //카카오로 시작하기
    @IBAction func loginButton(_ sender: UIButton) {
        loginManager.kakaoLogin()
    }
    
    //다른 방법으로 로그인하기
    @IBAction func OtherLoginButton(_ sender: UIButton) {
        presentReviewModalViewController()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //로그인 매니져 delegate 채택
        loginManager.delegate = self
        
        //slide show 초기설정
        slideShow.setImageInputs(images)
        slideShow.contentScaleMode = .scaleAspectFill
        slideShow.circular = false
        
        // ⚠️ slide show 의 인디케이터가 보이지 않는 현상 발생. 🚧👷🏻‍♂️🛠 해결중!!
            //constraint 카카오톡으로 로그인과 좀더 떨어트려보고 한번더 확인해보기.
            //이미지 자체를 바꿔서 도 확인 해보기
        let indicator = UIPageControl()
        indicator.currentPageIndicatorTintColor = UIColor.black
        indicator.pageIndicatorTintColor = UIColor.lightGray
        slideShow.pageIndicator = indicator
        
        
    }
}

//half modalView 띄우기
extension LoginViewController: UIViewControllerTransitioningDelegate {
        // ...
    
    //half modal view 띄우는 메서드
    private func presentReviewModalViewController() {
            let storyboard = UIStoryboard(name: "LoginStoryBoard", bundle: nil)
            guard let reviewModalViewController = storyboard.instantiateViewController(withIdentifier: "OtherLoginViewController") as? OtherLoginViewController else {
                return
            }
            
        reviewModalViewController.dismissDelegate = self
                
            reviewModalViewController.modalPresentationStyle = .custom
            reviewModalViewController.transitioningDelegate = self
            present(reviewModalViewController, animated: true, completion: nil)
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


extension LoginViewController: DismissDelegate {
    //다른 방법으로 로그인 시 호출 됨
    func dismiss() {
        self.dismiss(animated: true) {
            print("로그인 뷰 디스미스")
        }
    }
}


//MARK: - 로그인 delegate
extension LoginViewController: LoginDelegate {


    //로그인 완료시.
    func didLogin() {
        self.dismiss(animated: true) {
        }
    }
    
    //로그인 실패시.
    func loginFailed(message: String?) {
        self.presentAlert(title: "로그인 실패", message: message)
    }
    
    
    //소셜 로그인완료시 메인 서버 회원가입 요청
    func didSignUp(loginInfo: LoginInfo) {
        print(loginInfo.name + "wowowowowowow")
        
        self.loginManager.signUp(loginInfo: loginInfo)
    }
}
