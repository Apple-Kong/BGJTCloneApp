//
//  MockVC.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/14.
//

import UIKit



class WishCollctionViewController: UIViewController {
    
    private let wishListDataManager = WishListDataManager()
    private let wishDataManager = WishDataManager()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "관심상품"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
extension WishCollctionViewController: WishDelegate {
    func wishButtonTapped(index: Int) {
        
        print("---------\(index)")
        wishDataManager.deleteWishItem(itemID: items[index].item_id)
        self.items.remove(at: index)
        self.wishCollectionView.reloadData()
        self.presentBottomAlert(message: "찜 해제가 완료되었습니다.")
    }
}

extension WishCollctionViewController: WishListDelegate {
    func didFetch(items: [WishListResponse.Result]) {
        self.items = items
        print(items)
        self.wishCollectionView.reloadData()
        
        
    }
    
    func failure(message: String) {
        self.presentAlert(title: "불러오기 실패", message: message)
    }
}


extension WishCollctionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let item = items[indexPath.row]
        
        let vc = UIStoryboard(name: "DetailStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.itemID = item.item_id
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishCollectionViewCell", for: indexPath) as! WishCollectionViewCell
        
        let item = items[indexPath.row]
        
        cell.index = indexPath.row
        
        let url = URL(string: "https://bjclone.s3.ap-northeast-2.amazonaws.com/" + item.image_path)
        cell.itemIamgeView.kf.setImage(with: url)
        cell.titleLabel.text = item.title
        cell.priceLabel.text = String(item.price).insertComma + "원"
        cell.shopNameLabel.text = "\(item.shop_name) • \(item.created_at.stringToIntervalDateString())".localized
        cell.itemIamgeView.layer.masksToBounds = true
        cell.itemIamgeView.layer.cornerRadius = 20
        cell.deleagte = self
        
        if item.safety_pay == 1 {
            cell.safetyPayView.isHidden = false
        } else {
            cell.safetyPayView.isHidden = true
        }
        if let urlString = item.shop_image {
            print("\(urlString)")
            let userUrl = URL(string: "https://bjclone.s3.ap-northeast-2.amazonaws.com/" + urlString)
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
