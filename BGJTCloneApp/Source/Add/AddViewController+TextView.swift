//
//  AddViewController+TextView.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/12.
//

import UIKit


//MARK: - 플레이스 홀더 셋팅
extension AddViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        scrollView.contentOffset.y = textView.frame.origin.y - 100
        return true
    }
    
    
    
    
    func placeholderSetting() {
        
        let detailPlaceholder = "상품의 구입일자, 브랜드, 사용감 등을 적어주세요. 자세히 적을 수록 더 빨리 팔려요.(10자 이상)"
        
        detailTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        
        // 텍스트 뷰 플레이스 홀더 글꼴, 줄 간격 설정
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        detailTextView.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        let attributes = [NSAttributedString.Key.paragraphStyle : style,
                          NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        detailTextView.attributedText = NSAttributedString(string: detailPlaceholder, attributes: attributes)
        
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
        
        let detailPlaceholder = "상품의 구입일자, 브랜드, 사용감 등을 적어주세요. 자세히 적을 수록 더 빨리 팔려요.(10자 이상)"
        
        if textView.text.isEmpty {
            textView.text = detailPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}
