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
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    let loginManager = LoginManager()
    
    let images = [
        ImageSource(image: UIImage(named: "Login_1")!),
        ImageSource(image: UIImage(named: "Login_2")!),
        ImageSource(image: UIImage(named: "Login_3")!),
        ImageSource(image: UIImage(named: "Login_4")!)
        ]
    
    @IBOutlet weak var kakaoButton: UIButton!
    
    @IBAction func loginButton(_ sender: UIButton) {
        loginManager.kakaoLogin(delegate: self)
        

    }
    
    @IBAction func OtherLoginButton(_ sender: UIButton) {
        presentReviewModalViewController()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideShow.setImageInputs(images)
        slideShow.contentScaleMode = .scaleAspectFill
        slideShow.circular = false
        
        let indicator = UIPageControl()
        indicator.currentPageIndicatorTintColor = UIColor.black
        indicator.pageIndicatorTintColor = UIColor.lightGray

        slideShow.pageIndicator = indicator
       
        
        
        
    }
    
    //half modal view 띄우는 메서드
    private func presentReviewModalViewController() {
            let storyboard = UIStoryboard(name: "LoginStoryBoard", bundle: nil)
            guard let reviewModalViewController = storyboard.instantiateViewController(withIdentifier: "OtherLoginViewController") as? OtherLoginViewController else {
                return
            }
                
            reviewModalViewController.modalPresentationStyle = .custom
            reviewModalViewController.transitioningDelegate = self
            present(reviewModalViewController, animated: true, completion: nil)
    }
    
 
}

//half modalView 띄우기
extension LoginViewController: UIViewControllerTransitioningDelegate {
        // ...

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


extension LoginViewController {
    func didLogin() {
        self.dismiss(animated: true) {
            print("view dismiss")
        }
    }
    
    func loginFailure() {
        self.presentAlert(title: "로그인 실패", message: "다시 로그인 해주세요.")
    }
}
