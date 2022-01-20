//
//  AccountEditViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit

class AccountEditViewController: BaseViewController {
    
    let accountDataManager =  AccountDataManager.shared
    
    @IBAction func dismissButton(_ sender: UIButton) {
        
        guard let viewControllerStack = self.navigationController?.viewControllers else { return } // 뷰 스택에서 SettingViewController를 찾아서 거기까지 pop
        for viewController in viewControllerStack {
            if let settingView = viewController as? SettingViewController { self.navigationController?.popToViewController(settingView, animated: true) }
            
        }
    }
    
    var isEnroll: Bool  = true
    var accNum: String?
    
    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBOutlet weak var enrollButton: UIButton!
    @IBAction func enrollButtonTap(_ sender: UIButton) {
        if let name = ownerTextField.text, let bank = bankTextField.text, let num = numberTextField.text {
            
            if isEnroll {
                accountDataManager.addAccount(name: name, bankName: bank, accNum: num)
            } else {
                if let accNum = accNum {
                    accountDataManager.editAccount(changeAccountNum: accNum, name: name, bank: bank, account_num: num, for_sale: false, for_return: false)
                } else {
                    self.presentBottomAlert(message: "계좌 정보가 유효하지 않습니다.")
                }
            }
            self.navigationController?.popViewController(animated: false)
        } else {
            self.presentBottomAlert(message: "필수 정보를 입력해 주세요.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEnroll {
            
        } else {
            titleLabel.text = "계좌 수정"
            enrollButton.titleLabel?.attributedText = NSAttributedString(string: "수정 완료")
        }
        
        
        ownerTextField.addDoneButtonOnKeyboard()
        bankTextField.addDoneButtonOnKeyboard()
        numberTextField.addDoneButtonOnKeyboard()
        
        enrollButton.tintColor = UIColor(named: "BGpay")
        
//
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
//        //set image for button
//        let image = UIImage(systemName: "xmark")
//        image?.withRenderingMode(.alwaysTemplate)
//        image?.resizeImage(size: CGSize(width: 24, height: 24))
//        button.setImage(image, for: .normal)
//        //버튼 액션추가
//        button.addTarget(self, action: #selector(dismissButtonTap), for: .touchUpInside)
//
//    //            button.tintColor = .white
//        //set frame
//
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
//    @objc func dismissButtonTap() {
//        self.navigationController?.popViewController(animated: true)
//    }
}
