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
    let followDataManager = FollowDataManager()
    let wistDataManager = WishDataManager()
    
    
    var itemInfo: Item?
    var shopInfo: Shop?
    var reviewInfo: ResultReview?
    
    @IBOutlet weak var inquiryCountLabel: UILabel!
    var itemID: Int?
    
    //MARK: - 커스텀 네비게이션 바
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var tobBarTitleLabel: UILabel!
    @IBOutlet weak var topBarSearchButton: UIButton!
    @IBOutlet weak var topBarShareButton: UIButton!
    
    @IBOutlet weak var topBarBackButton: UIButton!
    
    @IBAction func topBarBackButtonTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Hiding Top bar
    var isHideAvailable = false
    var isShowAvailable = true
    @IBOutlet weak var hideBar: UIView!
    @IBOutlet weak var hidePriceLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var hideItemLabel: UILabel!
    
    @IBOutlet weak var hideReviewCountLabel: UILabel!
    @IBOutlet weak var hideIsTaekPoLabel: UILabel!
    @IBOutlet weak var hideShopLabel: UILabel!
    
    
    //MARK: - 찜하기 기능 관련
    var isWished = false {
        didSet {
            if let itemID = itemID {
                if isWished {
                    wishButton.isHighlighted = true
                    wistDataManager.addWishItem(itemID: itemID)
                    self.presentBottomAlert(message: "찜 목록에 추가했어요!   ")
                    
                   
                    
                } else {
                    wishButton.isHighlighted = false
                    wistDataManager.deleteWishItem(itemID: itemID)
                    self.presentBottomAlert(message: "찜 해제가 완료되었습니다.")
       
                    
                }
            }
        }
    }
    
    
    @IBAction func inquiryButtonTap(_ sender: UITapGestureRecognizer) {
        
        let vc = UIStoryboard(name: "DetailStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "InquiryViewController") as! InquiryViewController
        
        
        if let itemID = itemID {
            vc.itemID = itemID
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.presentBottomAlert(message: "item ID 가 존재하지 않습니다    ")
        }
    }
    
    @IBOutlet weak var wishButton: UIImageView!
    @IBAction func wishTap(_ sender: UITapGestureRecognizer) {
        isWished.toggle()
    }
    
    
    //MARK: - 거래 기능 관련
    //모달뷰 띄우는 걸로 추후에 변경할 것. >> 완료
    @IBAction func dealButtonTap(_ sender: UITapGestureRecognizer) {
        self.presentDealModalViewController()
       
        
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
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    
    //MARK: - 상점 UI
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    @IBOutlet weak var shopItemImageView1: UIImageView!
    @IBOutlet weak var shopItemImageView2: UIImageView!
    @IBOutlet weak var shopItemImageView3: UIImageView!
    
    @IBOutlet weak var shopItemViewHeightConstraint: NSLayoutConstraint!
    var isFollowing: Bool = false {
        didSet {
            if isFollowing {
                
                
                self.shopFollowButton.image = UIImage(named: "shop_follow_fill")
                
                
                if let shopInfo = shopInfo {
                    
                    followerLabel.text = String(Int(followerLabel.text!)! + 1)
                    
                    followDataManager.followShop(shopID: shopInfo.sellerID)
                    
                    let alert = UIStoryboard(name: "DetailStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "FollowModalView") as! FollowModalView
                    alert.modalPresentationStyle = .overCurrentContext
                    alert.delegate = self
                    present(alert, animated: false, completion: nil)
              
                } else {
                    self.presentBottomAlert(message: "상점 정보 없음     ")
                }
                
                
            } else {
                
                
                followerLabel.text = String(Int(followerLabel.text!)! - 1)
                
                self.shopFollowButton.image = UIImage(named: "follow_shop")
                if let shopInfo = shopInfo {
                    followDataManager.unFollowShop(shopID: shopInfo.sellerID)
                } else {
                    self.presentBottomAlert(message: "상점 정보 없음     ")
                }
            }
        }
    }
    @IBOutlet weak var shopFollowButton: UIImageView!
    @IBAction func followShopButtonTap(_ sender: UIButton) {
        
        
        //MARK: 🚧🚧 상점 팔로우 기능 구현 예정 🚧🚧
    }
    
 
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var reviewViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func followShop(_ sender: UITapGestureRecognizer) {
        isFollowing.toggle()
        
    }
    //네비게이션 바 아이템 탭 액션
    @objc func fbButtonPressed() {
        
        print("Share to fb")
    }
    

    
    //네비게이션 컨트롤러 초기화
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        

        
        //네비게이션 컨트롤러 투명하게 만들기
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        topBar.backgroundColor = .clear
        topBarBackButton.tintColor = .white
        topBarShareButton.tintColor = .white
        topBarSearchButton.tintColor = .white
        tobBarTitleLabel.tintColor = .clear
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBar.center.y = -50
        hideBar.isHidden = true
        
        
        topImageView.layer.masksToBounds = true
        topImageView.layer.cornerRadius = 4
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        
        detailDataManager.delegate = self
        if let itemID = itemID {
            self.showIndicator()
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
        discountView.layer.cornerRadius = 5
        discountView.layer.shadowOpacity = 0.1
        discountView.layer.shadowOffset = CGSize(width: 0, height: 6)
        discountView.layer.shadowRadius = 5
        discountView.layer.masksToBounds = false
        
        
        
        shopImage.maskToCircle()

    }
}

//MARK: - 결제화면 전환
extension DetailViewController: DealModalDelegate {
    func delivery() {
        let vc = UIStoryboard(name: "DealStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "DealViewController") as! DealViewController
        vc.dealType = 1
        vc.delegate = self
        
        
        if let itemInfo = self.itemInfo {
            let url = URL(string: (Constant.IMAGE_URL + itemInfo.images[0].imagePath))
            do {
                let data = try Data(contentsOf: url!)
                vc.image = UIImage(data: data)
            } catch {
                print(error.localizedDescription)
            }
            
            vc.itemName = itemInfo.title
            vc.price = String(itemInfo.price)
        }
        
        vc.itemID = itemID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func direct() {
        let vc = UIStoryboard(name: "DealStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "DealViewController") as! DealViewController
        vc.dealType = 0
        vc.delegate = self
        
        if let itemInfo = self.itemInfo {
            let url = URL(string: (Constant.IMAGE_URL + itemInfo.images[0].imagePath))
            do {
                let data = try Data(contentsOf: url!)
                vc.image = UIImage(data: data)
            } catch {
                print(error.localizedDescription)
            }
            vc.itemName = itemInfo.title
            vc.price = String(itemInfo.price)
        }
        vc.itemID = itemID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension DetailViewController {
    func dealCompleted() {
        self.presentBottomAlert(message: "상품 구매가 완료되었습니다!    ")
    }
}


//MARK: - 상세 페이지 UI 업데이트
extension DetailViewController: DetailDelegate {
    func failure(message: String) {
        self.dismissIndicator()
        self.presentAlert(title: "message")
    }
    
    func itemFetched(item: Item, shop: Shop, review: ResultReview) {
        
        self.itemInfo = item
        self.shopInfo = shop
        self.reviewInfo = review
        //MARK: - 아이템 구간
        let url = URL(string:  Constant.IMAGE_URL + item.images[0].imagePath)
        do {
            let data = try Data(contentsOf: url!)
            if let image = UIImage(data: data) {
                topImageView.image = image
            }
            
        } catch {
            print("\(error.localizedDescription)")
        }
        
        for imagePath in item.images {
            let url = URL(string: Constant.IMAGE_URL + imagePath.imagePath)
            do {
                let data = try Data(contentsOf: url!)
                if let image = UIImage(data: data) {
                    images.append(ImageSource(image: image))
                }
                
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        slideShow.setImageInputs(images)
        titleLabel.text = item.title
        hideItemLabel.text = item.title
        priceLabel.text = String(item.price).insertComma
        hidePriceLabel.text = String(item.price).insertComma
        inquiryCountLabel.text = "\(item.inquiryCount)"
        let attributedString = NSMutableAttributedString(string: " ")
           
        //삽입할 이미지
        var imageAttachment = NSTextAttachment()
        var image = UIImage(named: "create_at")
       
        imageAttachment.image = image
        
        imageAttachment.bounds = CGRect(x: 0, y: -3, width: 12, height: 12)
        
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        
        attributedString.append(NSAttributedString(string: " " + item.creatdAt.stringToIntervalDateString() + "  "))
        
        imageAttachment = NSTextAttachment()
        image = UIImage(named: "view_count")
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: -3, width: 14, height: 14)
        
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        
        attributedString.append(NSAttributedString(string: "  \(String(item.view))  "))
        
        
        imageAttachment = NSTextAttachment()
        image = UIImage(named: "detail_heart_fill")
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: -3, width: 14, height: 14)
        
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        
        attributedString.append(NSAttributedString(string: "  \(String(item.wishCount))"))

        postInfo.attributedText = attributedString
        
//        postInfo.text = item.creatdAt.stringToIntervalDateString()
        var condition = ""
        
        
        locationLabel.text = item.location ?? "지역정보 없음"
        if item.location == "" {
            locationLabel.text = "지역정보 없음"
        }
        
        if item.condition == 1 {
            condition = "새상품"
        } else {
            condition = "중고"
        }
        
        var deliveryFee = ""
        if item.deliveryFeeIncluded == 1 {
            deliveryFee = "배송비포함"
        } else {
            deliveryFee = "배송비별도"
        }
        hideIsTaekPoLabel.text = deliveryFee
        
        
        
        otherInfoLabel.text = "\(condition)  •  \(deliveryFee)  •  총\(item.count)개"
        
        detailTextView.text = item.detail
        
        if item.safetyPay == 1 {
            safePayBadgeView.isHidden = false
        } else {
            safePayBadgeView.isHidden = true
        }
//            postInfo.text = item.creatd_at.stringToIntervalDateString().localized
        
        var tags = ""
        
        for tag in item.tags {
            tags += "#\(tag.tagName) "
        }
       
        tagsLabel.text = tags
        
        
        //MARK: - shop 구간
        shopNameLabel.text = shop.shopName
        followerLabel.text = String(shop.followerCount)
        itemCountLabel.text = String(shop.itemCount)
        
        if shop.itemCount == 0 {
            shopItemViewHeightConstraint.constant = 0
        } else {
            for (index, item) in shop.shopItems.enumerated() {
                let url = URL(string: Constant.IMAGE_URL + item.imagePath)
                switch index {
                case 0:
                    shopItemImageView1.kf.setImage(with: url)
                case 1:
                    shopItemImageView2.kf.setImage(with: url)
                case 2:
                    shopItemImageView3.kf.setImage(with: url)
                default:
                    print("do not set image ")
                }
            }
        }
        
        
        hideShopLabel.text = shop.shopName
        
        
        
        //MARK: - review 구간
        if review.reviewCount == 0 {
            reviewViewHeightConstraint.constant = 0
        } else {
            reviewTableView.reloadData()
        }
        reviewCountLabel.text = String(review.reviewCount ?? 0)
        
        // 별점도 바꿔주기 🚧🚧🚧🚧🚧
        
        hideReviewCountLabel.text = "5.0 (\(review.reviewCount ?? 0))"
        
        self.dismissIndicator()
    }
    
    
}

//MARK: - 후기 데이터 받아오기
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = reviewInfo?.reviewCount {
            if count == 0 {
                return 0
            } else if count > 2 {
                return 2
            } else {
                return count
            }
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as! DetailTableViewCell
        
        if let reviews = reviewInfo?.reviews {
            for review in reviews {
                cell.shopNameLabel.text = review.buyerName
                if let imagePath = review.buyerImage {
                    let url = URL(string: Constant.IMAGE_URL + imagePath)
                    cell.shopImageView.kf.setImage(with: url)
                }
                
                cell.itemNameLabel.text = review.itemTitle
                cell.reviewLabel.text = review.content
                cell.createAtLabel.text = review.createdAt.stringToIntervalDateString()
                //아이템 이미지 가 안옴. 서버에서 임시 보류
//                if let imagePath = review. {
//                    let url = URL(string: Constant.IMAGE_URL + imagePath)
//                    cell.ItemImageView.kf.setImage(with: url)
//                }
            }
        }
        return cell
    }


}




//MARK: - 스크롤에 따른 UI 애니메이션 들
extension DetailViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        

            //MARK: 네비게이션 바 fade animation
        let offset = scrollView.contentOffset.y - 90
        
        print(self.hideBar.center.y)
        if offset > 420 && isShowAvailable {
            isShowAvailable = false
            
            self.hideBar.center.y = 119 - 50
            hideBar.isHidden = false
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                self.hideBar.center.y = 119
                            },
                           completion: { Void in
                self.isHideAvailable = true
            }
            )
            print("아래로 스크롤")
            
        }
        
        if offset < 420 && isHideAvailable {
            isHideAvailable = false
 
            self.hideBar.center.y = 119
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                self.hideBar.center.y = 119 - 50
                            },
                           completion: { Void in
                self.isShowAvailable = true
                self.hideBar.isHidden = true
            }
            )
            print("위로 스크롤")
            
        }
 
        
        var proportionalOffset =  offset / 130
        
        if proportionalOffset > 1 {
            proportionalOffset = 1
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: proportionalOffset)
            let tintColor = UIColor(hue: 1, saturation: 0, brightness: 1 - proportionalOffset, alpha: 1)

            let titleColor = UIColor(hue: 1, saturation: 0, brightness: 0, alpha: proportionalOffset)


            topBar.backgroundColor = color

            topBarBackButton.tintColor = tintColor
            topBarShareButton.tintColor = tintColor
            topBarSearchButton.tintColor = tintColor
            tobBarTitleLabel.textColor = titleColor
            
        } else {
            
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: proportionalOffset)
            let tintColor = UIColor(hue: 1, saturation: 0, brightness: 1 - proportionalOffset, alpha: 1)
            let titleColor = UIColor(hue: 1, saturation: 0, brightness: 0, alpha: proportionalOffset)
            
            topBar.backgroundColor = color
            
            topBarBackButton.tintColor = tintColor
            topBarShareButton.tintColor = tintColor
            topBarSearchButton.tintColor = tintColor
            tobBarTitleLabel.textColor = titleColor
        }
    }
}

extension DetailViewController: FollowAlertDelegate {
    func yesButtonTapped() {
        self.presentBottomAlert(message: "알림이 등록되었습니다       ")
    }
    
    func noButtonTapped() {
        //nothing
    }
}



//half modalView 띄우기
extension DetailViewController: UIViewControllerTransitioningDelegate {
        // ...
    
    //half modal view 띄우는 메서드
    private func presentDealModalViewController() {
            let storyboard = UIStoryboard(name: "DealModalStoryBoard", bundle: nil)
            guard let dealModalViewController = storyboard.instantiateViewController(withIdentifier: "DealModalViewController") as? DealModalViewController else {
                return
            }
            
        
        dealModalViewController.delegate = self
        dealModalViewController.modalPresentationStyle = .custom
        dealModalViewController.transitioningDelegate = self
        present(dealModalViewController, animated: true, completion: nil)
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let halfModalPC = HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
        halfModalPC.proportianoalYPosition = 0.56
        halfModalPC.proportionalHeight = 0.6
        return halfModalPC
    }
}


