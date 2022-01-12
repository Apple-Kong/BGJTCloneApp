//
//  AddViewController+DataSource.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/12.
//

import UIKit

//컬렉션뷰 delegate
extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 사진 추가시 최대 12개 까지 확장 가능.
        
        if collectionView == self.imageCollectionView {
            return selectedImages.count
        } else if collectionView == self.tagCollectionView {
            return tags.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.imageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            
            cell.deleteView.layer.cornerRadius = cell.deleteView.frame.height / 2
            cell.deleteView.layer.borderWidth = 1
            cell.deleteView.layer.borderColor = UIColor.systemGray5.cgColor
            
            
            //🚧🛠👷🏻‍♂️ cell 코너 radius 정해놓을 것...
        
            cell.image.image = selectedImages[indexPath.row]
            cell.image.layer.masksToBounds = true
            cell.image.layer.cornerRadius = 5
            
            return cell
            
        } else if collectionView == self.tagCollectionView {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagMainCell", for: indexPath) as! TagMainCollectionViewCell
            cell.tagLabel.text = "#" + tags[indexPath.row]
            
            return cell
            
        } else {
                return UICollectionViewCell()
            }

    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height: CGFloat = collectionView.frame.height
        let width: CGFloat = height
        if collectionView == imageCollectionView {
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: 0, height: 0)
        }
        
        
    }
    
    //MARK: - 헤더뷰
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == imageCollectionView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                
                //헤더 뷰 생성
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ImageCollectionReusableView", for: indexPath) as! ImageCollectionReusableView
                headerView.addImageButton.tintColor = .lightGray
                headerView.addImageButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
                headerView.layer.cornerRadius = 5
                
                //이미지 추가버튼 delegate
                headerView.delegate = self
                
                return headerView
           
            default:
                assert(false, "헤더 생성 오류")
            }
        } else {
            return UICollectionReusableView()
        }
    }
}
