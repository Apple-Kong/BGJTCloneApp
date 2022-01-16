//
//  AccountViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit

class AccountViewController: BaseViewController {
    
    let accountDataManager = AccountDataManager.shared
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    
    var accounts: [AccountResponse.Result] {
        get {
            accountDataManager.accounts
        }
    }
    
    @IBAction func addAccountButtonTap(_ sender: UITapGestureRecognizer) {
        
        let vc = UIStoryboard(name: "AccountEditStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "AccountEditViewController") as! AccountEditViewController
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        //싱글톤 객체로 데이터 불러오기.
        accountDataManager.getAccount()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountDataManager.deleagate = self
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.title = "계좌 등록"
        
        //dismiss 버튼 추가
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
        let image = UIImage(systemName: "xmark")
        image?.withRenderingMode(.alwaysTemplate)
        image?.resizeImage(size: CGSize(width: 24, height: 24))
        button.setImage(image, for: .normal)
        //버튼 액션추가
        button.addTarget(self, action: #selector(dismissButtonTap), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)

    }
    @objc func dismissButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AccountViewController: ButtonInsideCellDelegate {
    func buttonTapped(index: Int) {
        // 계좌 수정 삭제 모달뷰 띄우기.
        presentMoreModalViewController(index: index)
    }
}

extension AccountViewController: AccountDelegate {
    func accountUpdated() {
        self.tableView.reloadData()
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
        
        
        cell.index = indexPath.row
        cell.delegate = self
        let account = accounts[indexPath.row]
        cell.nameLabel.text = account.bank
        cell.numberLabel.text = account.account_number
        cell.ownerLabel.text = account.user_name
        
        return cell
    }
}


//MARK: - half modalView 띄우기
extension AccountViewController: UIViewControllerTransitioningDelegate {
        // ...
    
    //half modal view 띄우는 메서드
    private func presentMoreModalViewController(index: Int) {
            let storyboard = UIStoryboard(name: "AccountStoryBoard", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "MoreModalViewController") as? MoreModalViewController else {
                return
            }
            
        vc.index = index
        

        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
            present(vc, animated: true, completion: nil)
        
        
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let halfModalPC = HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
        halfModalPC.proportianoalYPosition = 0.75
        halfModalPC.proportionalHeight = 0.5
        
        return halfModalPC
    }
}
