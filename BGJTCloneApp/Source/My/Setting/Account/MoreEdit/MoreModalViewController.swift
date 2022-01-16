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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func deleteButtonTap(_ sender: UIButton) {
        
        let account_num = accountDataManger.accounts[index].account_number
        
        accountDataManger.deleteAccount(account_num: account_num)
        
        self.dismiss(animated: true) {
            print("more Modal dismiss")
            self.accountDataManger.getAccount()
        }
    }
    
    
    @IBAction func editButtonTap(_ sender: UIButton) {
    }
}
