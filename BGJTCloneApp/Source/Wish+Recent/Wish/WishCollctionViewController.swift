//
//  MockVC.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/14.
//

import UIKit



class WishCollctionViewController: UIViewController {
    
    private let wishListDataManager = WishListDataManager()
    
    var items: [WishListResponse.Result] = []


    @IBOutlet weak var wishCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishListDataManager.delegate = self
        
        wishCollectionView.contentInset.top = 10
        wishCollectionView.delegate = self
        wishCollectionView.dataSource = self
 
        wishListDataManager.fetchData()
  
    }
}

extension WishCollctionViewController: WishListDelegate {
    func didFetch(items: [WishListResponse.Result]) {
        self.items = items
        self.wishCollectionView.reloadData()
        
        
    }
    
    func failure(message: String) {
        self.presentAlert(title: "불러오기 실패", message: message)
    }
}


extension WishCollctionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let item = items[indexPath.row]
        let data = RecommendResponse.Result(item_id: item.item_id, title: item.title, price: item.price, safety_pay: item.safety_pay, location: "지역정보 없음", created_at: item.created_at, image_path: item.image_path, wish_count: 0)
        
        let vc = UIStoryboard(name: "DetailStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        if item.safety_pay == 1 {
            vc.item = (data, true)
        } else {
            vc.item = (data, false)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishCollectionViewCell", for: indexPath) as! WishCollectionViewCell
        
        let item = items[indexPath.row]
        
        let url = URL(string: item.image_path)
        cell.itemIamgeView.kf.setImage(with: url)
        cell.titleLabel.text = item.title
        cell.priceLabel.text = String(item.price).insertComma + "원"
        cell.shopNameLabel.text = item.shop_name
        cell.itemIamgeView.layer.masksToBounds = true
        cell.itemIamgeView.layer.cornerRadius = 20
        
        if let urlString = item.shop_image {
            let userUrl = URL(string: urlString)
            cell.userImageView.kf.setImage(with: userUrl)
        }
        
        cell.userImageView.maskToCircle()
        
        return cell
    }
}



//MARK: - 컬렉션 뷰 레이아웃 수정
extension WishCollctionViewController: UICollectionViewDelegateFlowLayout {
    //행
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //행간 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //사이즈 조정
        
        let width = collectionView.frame.width / 2 - 5
        let height = width * 1.5
        let size = CGSize(width: width, height: height)
        return size
    }
}
