//
//  RecommendViewController+DataSource.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/11.
//

import UIKit
import Kingfisher


//MARK: - 컬렉션 뷰 항목 개수, 셀로의 정보 전달.
extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
        
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "DetailStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.itemID = items[indexPath.row].0.item_id
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! RecommendCollectionViewCell
        
        let item = items[indexPath.row].0
        let isWishItem = items[indexPath.row].1
        
        
        
        cell.titleLabel.text = item.title
        cell.priceLabel.text = String(item.price).insertComma
        
        var location = item.location
        if location == "" {
            location  = "위치정보 없음"
        }
        cell.locationLabel.text = "\(location) • \(item.created_at.stringToIntervalDateString())".localized
        
        print("--------\(item.created_at.stringToIntervalDateString())------")
      
        let url = URL(string: Constant.IMAGE_URL + item.image_path)
        cell.image.kf.setImage(with: url)
            
     
        
        if item.safety_pay == 1 {
            //셀 뱃지 보이기
            cell.BGpayImageView.isHidden = false
        } else {
            //셀 뱃지 숨기기
            cell.BGpayImageView.isHidden = true
        }
        
        if isWishItem {
            // 버튼 빨갛게
            print("버튼 빨갛게~")
            cell.wishButton.setBackgroundImage(UIImage(named: "main_heart_fill"), for: UIControl.State.normal)
        } else {
            // 버튼 하얗게
            cell.wishButton.setBackgroundImage(UIImage(named: "main_heart"), for: UIControl.State.normal)
            
        }
        
        
        
        cell.image.layer.masksToBounds = true
        cell.image.layer.cornerRadius = 16
        cell.delegate = self
        cell.index = indexPath.row
        
        
        return cell
    }
}


//MARK: - 컬렉션 뷰 레이아웃 수정
extension  RecommendViewController: UICollectionViewDelegateFlowLayout {
    
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
        let height = width * 2.2
        let size = CGSize(width: width, height: height)
        return size
    }
}
