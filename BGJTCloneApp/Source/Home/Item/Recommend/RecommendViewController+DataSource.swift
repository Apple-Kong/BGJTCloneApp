//
//  RecommendViewController+DataSource.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/11.
//

import UIKit


//MARK: - 컬렉션 뷰 항목 개수, 셀로의 정보 전달.
extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! RecommendCollectionViewCell
        
        cell.image.layer.masksToBounds = true
        cell.image.layer.cornerRadius = 16
        return cell
    }
}

//MARK: - 컬렉션 뷰 레이아웃 수정
extension  RecommendViewController: UICollectionViewDelegateFlowLayout {
    
    //행
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //행간 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //사이즈 조정
        
        let width = collectionView.frame.width / 2 - 10
        let height = width * 2.2
        let size = CGSize(width: width, height: height)
        return size
    }
}
