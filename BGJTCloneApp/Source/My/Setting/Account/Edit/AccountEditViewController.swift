//
//  AccountEditViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit

class AccountEditViewController: BaseViewController {
    
    let accountDataManager =  AccountDataManager.shared
    
    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    
    @IBOutlet weak var enrollButton: UIButton!
    @IBAction func enrollButtonTap(_ sender: UIButton) {
        if let name = ownerTextField.text, let bank = bankTextField.text, let num = numberTextField.text {
            
            
            print(name)
            
            accountDataManager.addAccount(name: name, bankName: bank, accNum: num)
            
            self.navigationController?.popViewController(animated: true)
        } else {
            self.presentAlert(title: "필수 정보 입력", message: "필수 정보를 입력해주세요.")
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ownerTextField.addDoneButtonOnKeyboard()
        bankTextField.addDoneButtonOnKeyboard()
        numberTextField.addDoneButtonOnKeyboard()
        
        enrollButton.tintColor = UIColor(named: "BGpay")
        
        self.navigationController?.title = "계좌 관리"
    
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        //set image for button
        let image = UIImage(systemName: "xmark")
        image?.withRenderingMode(.alwaysTemplate)
        image?.resizeImage(size: CGSize(width: 24, height: 24))
        button.setImage(image, for: .normal)
        //버튼 액션추가
        button.addTarget(self, action: #selector(dismissButtonTap), for: .touchUpInside)
        
    //            button.tintColor = .white
        //set frame
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func dismissButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
