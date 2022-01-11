//
//  RecommendViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit

class RecommendViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var scrollDelegate: NestedScrollDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        

    }
}


//MARK: - 중첩 스크롤 해결
extension RecommendViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < -5 {
            //하위 스크롤이 맨위에 닿는 다면 delegate 메서드 실행
            scrollDelegate?.scrollDidEndTop()
            
            //스크롤이 맨위까지 닿는다면 하위 스크롤 잠금
            collectionView.isScrollEnabled = false
            
            //0.4 초 뒤에 바로 해제
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
                
                self.collectionView.isScrollEnabled = true
            }
           
        }
    }
}
