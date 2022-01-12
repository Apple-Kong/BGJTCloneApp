//
//  AddViewController+FlowLayout.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/12.
//

import UIKit


//컬렉션 뷰 셀 크기 조정
extension AddViewController: UICollectionViewDelegateFlowLayout {
 

    //아이템간 거리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == imageCollectionView {
            return 10
        } else {
            
            //태그 컬렉션뷰 간격
            return 3
        }
        
    }
    
    //행간 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == imageCollectionView {
            return 10
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //사이즈 조정
        
        if collectionView == self.imageCollectionView {
            let height = collectionView.frame.height
            let width = height
            let size = CGSize(width: width, height: height)
            return size
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagMainCell", for: indexPath) as! TagMainCollectionViewCell
            
            cell.tagLabel.text = tags[indexPath.row]
            cell.tagLabel.sizeToFit()
            
            let cellWidth = cell.tagLabel.frame.width + 24
            return CGSize(width: cellWidth, height: 16)
            
        }
    }
}
