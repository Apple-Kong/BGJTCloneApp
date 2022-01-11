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
