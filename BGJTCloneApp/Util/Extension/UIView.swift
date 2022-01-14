//
//  UIView.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import Foundation
import UIKit



// 동적인 UIView constraint 수정을 위한 확장
extension UIView {
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }

    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}


//MARK: - 버튼 선택 비선택 셋팅 > OptionChoiceViewController 참고.
extension UIView {
    func roundedBorder() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray6.cgColor
        
    }
    
    func roundedBorder(radius: CGFloat, borderWidth: CGFloat, color: UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
    func isSelectedColoring(isSelected: Bool) {
        
        if isSelected {
            self.layer.borderColor = UIColor(named: "main_background")?.cgColor
            self.backgroundColor = UIColor(named: "main_background")
            self.tintColor = UIColor(named: "badge")
        } else {
            self.layer.borderColor = UIColor.systemGray6.cgColor
            self.backgroundColor = nil
            self.tintColor = .lightGray
        }
    }
    
    func maskToCircle() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
}
