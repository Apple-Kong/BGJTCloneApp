//
//  UIApplication.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import Foundation
import UIKit


//iOS 13 이상에서 status bar의 프로퍼티 변경을 위한 확장
extension UIApplication {
    class var statusBarView: UIView? {
        var statusBarView: UIView?
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
                statusBarView = statusBar
                
            } else {
                let statusBar = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBar.tag = tag
                UIApplication.shared.keyWindow?.addSubview(statusBar)
                statusBarView = statusBar
                
            }
            
        } else {
            statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
            
        }
        return statusBarView }
    
    
    class var statusBarBackgroundColor: UIColor? {
        get {
            return statusBarView?.backgroundColor
            
        } set { statusBarView?.backgroundColor = newValue }
    }
    
}
