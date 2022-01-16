//
//  DetailViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/14.
//

import UIKit
import ImageSlideshow
import Kingfisher


class DetailViewController: UIViewController {
    
    let detailDataManager = DetailDataManager()
    
    var itemInfo: DetailResponse.Result.Item?
    var shopInfo: DetailResponse.Result.Shop?
    var reviewInfo: DetailResponse.Result.Review?
    
    var itemID: Int?
    
    
    
    
    //MARK: - 찜하기 기능 관련
    var isWished = false {
        didSet {
            if isWished {
                wishButton.isHighlighted = true
            } else {
                wishButton.isHighlighted = false
            }
        }
    }
    
    @IBOutlet weak var wishButton: UIImageView!
    @IBAction func wishTap(_ sender: UITapGestureRecognizer) {
        isWished.toggle()
    }
    
    
    //MARK: - 거래 기능 관련
    //모달뷰 띄우는 걸로 추후에 변경할 것.
    @IBAction func dealButtonTap(_ sender: UITapGestureRecognizer) {
        let vc = UIStoryboard(name: "DealStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "DealViewController") as! DealViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    //슬라이드쇼
    @IBOutlet weak var slideShow: ImageSlideshow!
    var images: [ImageSource] = []
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - 아이템 UI
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var safePayBadgeView: UIImageView!
    @IBOutlet weak var postInfo: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var otherInfoLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet var inquiryButtonTap: UITapGestureRecognizer!
    
    
    
    //MARK: - 상점 UI
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    @IBAction func followShopButtonTap(_ sender: UIButton) {
        
        
        //MARK: 🚧🚧 상점 팔로우 기능 구현 예정 🚧🚧
    }
    
 
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    
    //네비게이션 바 아이템 탭 액션
    @objc func fbButtonPressed() {

        print("Share to fb")
    }
    
    
    //네비게이션 컨트롤러 초기화
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem!.title = " "
        //네비게이션 컨트롤러 투명하게 만들기
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailDataManager.delegate = self
        if let itemID = itemID {
            detailDataManager.fetch(itemID: itemID)
        } else {
            self.presentAlert(title: "no item ID")
        }
        
        
        
        //MARK: - 슬라이드쇼 초기화
        //slide show 인디케이터 초기화
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor(named: "BGpay")
        pageIndicator.pageIndicatorTintColor = .lightGray
        slideShow.pageIndicator = pageIndicator
        slideShow.setImageInputs(images)
        slideShow.contentScaleMode = .scaleAspectFill
        
        
        //MARK: - 스크롤 뷰
        scrollView.delegate = self
        scrollView.contentInset.top = -90
        
        //MARK: - 뷰 컴포넌트 업데이트 🚧 상품 상세 페이지 데이터로 수정예정
        
        
        
        
        //MARK: - 이벤트 뷰 커스텀.
        discountView.layer.shadowOpacity = 0.1
        discountView.layer.shadowOffset = CGSize(width: 0, height: 6)
        discountView.layer.shadowRadius = 5
        discountView.layer.masksToBounds = false
        
        
        
        shopImage.maskToCircle()
        

        //MARK: - 네비게이션 바 아이템 추가
        
        let buttonStrings = ["edit", "filter"]
        var buttons: [UIBarButtonItem] = []
        for string in buttonStrings {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
            //set image for button
            let image = UIImage(named: string)
            
            image?.withRenderingMode(.alwaysTemplate) // 렌더링 모드 수정 필수 >> 컬러 변경 위ㅎ함
            image?.resizeImage(size: CGSize(width: 24, height: 24)) // 리사이징도 필수 이미지 사이즈가 더 크면 오류남.
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(fbButtonPressed), for: .touchUpInside)
            buttons.append(UIBarButtonItem(customView: button))
        }
        self.navigationItem.rightBarButtonItems = buttons
        
        //네비게이션 바 타이틀 수정
        self.navigationController?.navigationBar.topItem!.title = " "
    }
}


//MARK: - 상세 페이지 UI 업데이트
extension DetailViewController: DetailDelegate {
    func itemFetched(item: DetailResponse.Result.Item, shop: DetailResponse.Result.Shop, review: DetailResponse.Result.Review) {
        
        //MARK: - 아이템 구간
        if let item = self.itemInfo {
            for imagePath in item.images {
                let url = URL(string: imagePath)
                let data = try? Data(contentsOf: url!)
                images.append(ImageSource(image: UIImage(data: data!)!))
            }
            titleLabel.text = item.title
            priceLabel.text = String(item.price).insertComma
            
            var condition = ""
            
            if item.condition == 1 {
                condition = "새상품"
            } else {
                condition = "중고"
            }
            
            var deliveryFee = ""
            if item.delivery_fee_included == 1 {
                deliveryFee = "배송비포함"
            } else {
                deliveryFee = "배송비별도"
            }
            
            
            
            otherInfoLabel.text = "\(condition) • \(deliveryFee) • 총\(item.count)개"
            
            detailTextView.text = item.detail
            
            if item.safety_pay == 1 {
                safePayBadgeView.isHidden = false
            } else {
                safePayBadgeView.isHidden = true
            }
            postInfo.text = item.creatd_at.stringToIntervalDateString().localized
            
           
            
        }
        
        
        //MARK: - shop 구간
        if let shop = self.shopInfo {
//            let url = URL(string: shop.)
//            imageView.kf.setImage(with: url)
//            shopImage.kf.setImage(url:)
            
            shopNameLabel.text = shop.shop_name
            followerLabel.text = String(shop.follower_count)
            itemCountLabel.text = String(shop.item_count)
        }
        
        
        
        //MARK: - review 구간
        if let review = self.reviewInfo {
            reviewCountLabel.text = String(review.review_count)
            
            // 별점도 바꿔주기 🚧🚧🚧🚧🚧
        }
    }
    
    func failure(message: String) {
        self.presentAlert(title: "네트워크 에러", message: message)
    }
}

//MARK: - 후기 데이터 받아오기
//extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//
//
//}

//MARK: - 스크롤에 따른 UI 애니메이션 들
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            //MARK: 네비게이션 바 fade animation
        let offset = scrollView.contentOffset.y
        var proportionalOffset =  offset / 80
        
        if proportionalOffset > 1 {
            proportionalOffset = 1
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: proportionalOffset)
            let tintColor = UIColor(hue: 1, saturation: 0, brightness: 1 - proportionalOffset, alpha: 1)
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
            
        } else {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: proportionalOffset)
            let tintColor = UIColor(hue: 1, saturation: 0, brightness: 1 - proportionalOffset, alpha: 1)
            
            self.navigationController?.navigationBar.tintColor = tintColor
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: tintColor]
            self.navigationController?.navigationBar.backgroundColor = color
        }
    }
}



