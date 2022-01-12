//
//  UITextField.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit

extension UITextField {
    
    //키보드에 닫기 버튼 추가
    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title:  NSLocalizedString("keyboard_close", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
            done.title = "닫기"
            done.tintColor = .black

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
            self.resignFirstResponder()
    }
}
