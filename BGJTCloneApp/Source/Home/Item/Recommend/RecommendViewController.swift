//
//  RecommendViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit

class RecommendViewController: UIViewController {
    
    private let wishDataManager = WishDataManager()
    private let recommendDataManager = RecommendDataManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var scrollDelegate: NestedScrollDelegate?
    var isAvailable = true
    //두번째 값은 찜 여부 저장
    var items: [(RecommendResponse.Result, Bool)] = []
    /*
     가짜데이터 보류
     (RecommendResponse.Result.init(item_id: 10000, title: "UI 테스트용", price: 93000, safety_pay: 1, location: "위치 정보 없음", created_at: "2022-01-11T08:26:48.000Z", image_path: "https://mblogthumb-phinf.pstatic.net/MjAyMDAxMDRfMjA2/MDAxNTc4MTMyNzAxMjYz.yBk7jsrSdixXGjcIPGzG7mL0jGkVVU842ejDu_tBpXQg.Xuc0pBCzgd9YADo6PGw4SsD4lg8tWnSLC-5XWcX_sVcg.JPEG.rampee/KakaoTalk_20200104_190829566.jpg?type=w800", wish_count: 3), true)
     */
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        recommendDataManager.delegate = self
        
        //첫번째 페이지 가져오기
        recommendDataManager.fetchData(page: 0)
        
        
    }
}


extension RecommendViewController: WishDelegate, RecommendDelegate {
    func didFetchedData(items: [RecommendResponse.Result]?) {
        
        if let items = items {
            for item in items {
                self.items.append((item, false))
            }
            self.collectionView.reloadData()
            isAvailable = true
        }
    }
    
    func wishButtonTapped(index: Int) {
        //인덱스 패스로 찜하기 요청.
        
        let itemID = items[index].0.item_id
        
        if items[index].1 {
            //delete wish
            wishDataManager.deleteWishItem(itemID: itemID)
            items[index].1 = false
            print(items[index].1)
            
        } else {
            //add wish
            wishDataManager.addWishItem(itemID: itemID)
            items[index].1 = true
            print(" wow items\(items[index].1)")
        }
        
        collectionView.reloadData()
    }
}


//MARK: - 중첩 스크롤 해결
extension RecommendViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.bounds.size.height {
                    
                    if isAvailable {
                        isAvailable = false
                        page += 1
                        recommendDataManager.fetchData(page: page)
                        print("-----현재 페이지 :\(page)------")
                }

            }
        
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
