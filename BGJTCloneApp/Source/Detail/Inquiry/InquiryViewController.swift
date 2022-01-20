//
//  InquiryViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/19.
//

import UIKit
import Kingfisher

class InquiryViewController: UIViewController {
    
    var itemID = 0
    var inquirys: [InquiryResult] = []
    var isKeyBoardShown = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var quiryViewBottomConstraint: NSLayoutConstraint!
    let inquiryDataManager = InquiryDataManager()
    
    @IBOutlet weak var inquiryView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func AddInquiryButton(_ sender: UIButton) {
        if let content = textField.text {
            inquiryDataManager.addInquiry(itemID: itemID, content: content)
        } else {
            self.presentBottomAlert(message: "문의사항을 입력해주세요      ")
        }
    }
    
    @IBAction func tapBackgroundView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.dismissKeyboardWhenTappedAround()
        
        inquiryDataManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        inquiryDataManager.getInquiry(itemID: itemID)
        
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardNotifications()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension InquiryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inquirys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InquiryTableViewCell", for: indexPath) as! InquiryTableViewCell
        
        let inquiry = inquirys[indexPath.row]
        
        cell.delegate = self
        cell.index = indexPath.row
        
        cell.shopNameLabel.text = inquiry.shop_name
        cell.contentLabel.text = inquiry.content
        cell.createAtLabel.text = inquiry.created_at.stringToIntervalDateString()
        
        
        //상점 이미지 받아오면 ㄲ
//        let url = URL(string: Constant.IMAGE_URL + inquiry.shop_image)
//        cell.shopImageView.kf.setImage(with: url)
//
        
        
        return cell
    }
}


extension InquiryViewController {
    func replyButtonTap(index: Int) {
        
    }
    
    func deleteButtonTap(index: Int) {
        
        inquiryDataManager.deleteInquiry(inquiryID: self.inquirys[index].inquiry_id)
    }
}


extension InquiryViewController {
    func gotInquirys(data: [InquiryResult]) {
        self.inquirys = data
        self.tableView.reloadData()
    }
    
    func updated() {
        self.inquiryDataManager.getInquiry(itemID: itemID)
        self.tableView.reloadData()
    }
    
    func failure(message: String) {
        self.presentBottomAlert(message: "네트워크 실패    ")
    }
}



extension InquiryViewController {
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height - 40

            
            if !isKeyBoardShown {
                isKeyBoardShown = true
                UIView.animate(withDuration: 1) {
                    self.inquiryView.window?.frame.origin.y -= keyboardHeight
                }
            }
 
            
        }
        
    } // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
 
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height - 40

            
                self.inquiryView.window?.frame.origin.y += keyboardHeight
            isKeyBoardShown = false

        }
    }
}
