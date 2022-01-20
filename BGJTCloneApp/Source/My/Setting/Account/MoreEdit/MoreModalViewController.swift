//
//  MoreModalViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit


class MoreModalViewController: UIViewController {
    
    var index = 0
    let accountDataManger = AccountDataManager.shared
    var delegate: EditAccountDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func deleteButtonTap(_ sender: UIButton) {
        
        
        
        
//        let account_num = accountDataManger.accounts[index].account_number
//
//        accountDataManger.deleteAccount(account_num: account_num)
//
        self.dismiss(animated: true) {
            print("more Modal dismiss")
            self.delegate?.deleteButtonTap(index: self.index)
        }
    }
    
    
    @IBAction func editButtonTap(_ sender: UIButton) {
        
        
        
        dismiss(animated: true) {
            self.delegate?.editButtonTap(index: self.index)
        }
        
    }
}

protocol EditAccountDelegate {
    func deleteButtonTap(index: Int)
    func editButtonTap(index: Int)
}
