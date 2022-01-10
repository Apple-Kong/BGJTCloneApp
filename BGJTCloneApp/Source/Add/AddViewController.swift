//
//  AddViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit

class AddViewController: UIViewController {
    
    let detailPlaceholder = "상품의 구입일자, 브랜드, 사용감 등을 적어주세요. 자세히 적을 수록 더 빨리 팔려요.(10자 이상)"
    
    @IBOutlet weak var titleBarView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func categoryButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func tagButtonTap(_ sender: UIButton) {
    }
    
    
    @IBAction func titleTextField(_ sender: UITextField) {
    }
    
    @IBOutlet weak var taekPoButton: UIButton!
    @IBAction func taekPoButton(_ sender: UIButton) {
        
        
 
    }
    
 
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var priceBarView: UIView!
    @IBOutlet weak var optionButton: UIButton!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //텍스트 필드 플레이스 홀더 세팅
        placeholderSetting()
        
        
        //옵션 버튼 커스텀
        optionButton.layer.borderColor = UIColor.gray.cgColor
        optionButton.layer.borderWidth = 1
        optionButton.layer.cornerRadius = 5
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self

        titleTextField.delegate = self
        priceTextField.delegate = self
    }
}

extension AddViewController: UITextViewDelegate {
    func placeholderSetting() {
        detailTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        detailTextView.text = detailPlaceholder
        detailTextView.textColor = UIColor.lightGray
        
    }
    
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = detailPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}


extension AddViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //해당 텍스트 필드 입력 시작시 하단 바 검정색으로 변경
        if textField == self.titleTextField {
            titleBarView.backgroundColor = .black
        } else {
            priceBarView.backgroundColor = .black
        }
        
    }
    //텍스트 필드 입력 종료시 하단 바 회색으로 변경
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.titleTextField {
            titleBarView.backgroundColor = .lightGray
        } else {
            priceBarView.backgroundColor = .lightGray
        }
    }
}


//컬렉션뷰 delegate
extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 사진 추가시 최대 12개 까지 확장 가능.
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height: CGFloat = collectionView.frame.height
        let width: CGFloat = height
       
        return CGSize(width: width, height: height)
        
    }

    
    //헤더뷰
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            //헤더 뷰 생성
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ImageCollectionReusableView", for: indexPath) as! ImageCollectionReusableView
            return headerView
       
        default:
            assert(false, "헤더 생성 오류")
        }
    }
}


//컬렉션 뷰 셀 크기 조정
extension AddViewController: UICollectionViewDelegateFlowLayout {
    //아이템간 거리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //행간 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //사이즈 조정
        let height = collectionView.frame.height
        let width = height
        let size = CGSize(width: width, height: height)
        return size
    }
}
