//
//  HomeViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/08.
//

import UIKit
import ImageSlideshow
import Tabman
import Pageboy

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var customTabViewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorBackgroundView: UIView!
    let MaxTopHeight: CGFloat = 50
    let MinTopHeight: CGFloat = 50
    
    //기기에 따라서 달라질 수 있기에 뷰의 높이와 엮는 게 좋을 듯.
    var threshold: CGFloat = 370
    
    let images = [ImageSource(image: UIImage(named: "Event_0")!),
                      ImageSource(image: UIImage(named: "Event_1")!),
                      ImageSource(image: UIImage(named: "Event_2")!),
                    ]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .white
        UIApplication.statusBarBackgroundColor = .clear
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.statusBarBackgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 컨트롤러 투명하게 만들기
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        buttonCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 160, bottom: 0, right: 160)
        
        
        //delegate 설정
        scrollView.delegate = self
        slideShow.setImageInputs(images)
        slideShow.contentScaleMode = .scaleAspectFill
        
        
        
        
        buttonCollectionView.delegate = self
        buttonCollectionView.dataSource = self
        
        
        if !UserDefaults.standard.bool(forKey: "isLogin") {
            
            let storyBoard = UIStoryboard(name: "LoginStoryBoard", bundle: nil)
            let loginVC: LoginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            loginVC.modalPresentationStyle = .fullScreen
            
            self.present(loginVC, animated: true, completion: nil)
        }
    }
}


//MARK: - 중첩 스크롤 문제를 해결하기 위한 뷰컨트롤러간 소통


//MARK: - 치명적인 오류 발생 컬렉션 뷰 스크롤이 될 만큼 아이템이 충분하지 않을 시 상위 뷰 컨트롤러 스크롤 그대로 정지해버림
protocol NestedScrollDelegate {
    func scrollDidEndTop()
}


extension HomeViewController: NestedScrollDelegate {
    
    func scrollDidEndTop() {
        scrollView.isScrollEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "toItem" {
          let viewController: HomeItemViewController = segue.destination as! HomeItemViewController
          viewController.scrollDelegate = self
       }
   }
}



//MARK: - 스크롤에 따른 UI 애니메이션 들
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.buttonCollectionView {
            
            let offset = scrollView.contentOffset.x / 6
            
            indicatorLeadingConstraint.constant = offset
        }
        
        
        
        // 스크롤 뷰에 한해서만 동작하게 끔 설정.
        if scrollView == self.scrollView {

            let offset = scrollView.contentOffset.y
            
            //MARK: Sticky header 🚧👷🏻‍♂️🛠 재구현 예정,,, 스티키 헤더 구글 검색해서 해결할 예정.
            if offset > self.threshold {
                scrollView.contentOffset = CGPoint(x: 0, y: self.threshold)
                
                //상위 뷰 스크롤 정지.
                scrollView.isScrollEnabled = false
             }

            //MARK: 이미지 슬라이드 헤더 stick to top
            if offset < 0 {
                slideShow.heightConstraint?.constant = 210 - offset
                headerTopConstraint.constant = offset
            } else {
                slideShow.heightConstraint?.constant = 210
            }
            
            //MARK: 네비게이션 바 fade animation
            
            var proportionalOffset =  offset / 80
            
            if proportionalOffset > 1 {
                proportionalOffset = 1
                let color = UIColor(red: 1, green: 1, blue: 1, alpha: proportionalOffset)
                self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: 0, brightness: 1 - proportionalOffset, alpha: 1)
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.statusBarBackgroundColor = color
                
                
            } else {
                let color = UIColor(red: 1, green: 1, blue: 1, alpha: proportionalOffset)
                self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: 0, brightness: 1 - proportionalOffset, alpha: 1)
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.statusBarBackgroundColor = color
            }
        }
    }
}



