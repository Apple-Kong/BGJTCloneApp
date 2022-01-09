//
//  HomeViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/08.
//

import UIKit
import ImageSlideshow

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var customTabViewTopHeight: NSLayoutConstraint!
    
    let MaxTopHeight: CGFloat = 50
    let MinTopHeight: CGFloat = 50
    
    let images = [ImageSource(image: UIImage(named: "Event_0")!),
                      ImageSource(image: UIImage(named: "Event_1")!),
                      ImageSource(image: UIImage(named: "Event_2")!),
                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 컨트롤러 투명하게 만들기
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        scrollView.delegate = self
        slideShow.setImageInputs(images)
        slideShow.contentScaleMode = .scaleAspectFill
        buttonCollectionView.delegate = self
        buttonCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //스크롤 뷰 컨텐츠의 첫 위치를 화면에 꽉차게 수정.
        print(scrollView.contentOffset.y)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        print(offset)
        
       //고정되어야 하는 위치 - 뷰 높이
        let threshold: CGFloat = 380
        if offset > threshold {
            scrollView.contentOffset = CGPoint(x: 0, y: 380)
        }
        
        //이미지 슬라이드 헤더 stick to top
        if offset < 0 {
            slideShow.heightConstraint?.constant = 240 - offset
            headerTopConstraint.constant = offset
        } else {
            slideShow.heightConstraint?.constant = 240
        }
       
        var proportionalOffset =  offset / 100
        //네비게이션 바 fade animation
        if proportionalOffset > 1 {
            proportionalOffset = 1
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: proportionalOffset)
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: proportionalOffset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.statusBarBackgroundColor = color
            
            
        } else {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: proportionalOffset)
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: proportionalOffset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = color
            UIApplication.statusBarBackgroundColor = color
        }
    }
}
