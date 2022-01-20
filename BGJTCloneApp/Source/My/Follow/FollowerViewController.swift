//
//  FollowerViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import UIKit

class FollowerViewController: UIViewController {
    
    let followListDataManager = FollowingListDataManager()
    
    var users: [FollowerInfo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followListDataManager.followerDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        followListDataManager.fetchFollowerList()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func goBackButtonTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}


extension FollowerViewController: FollowerListDelegate {
    func didFetched(data: [FollowerInfo]) {
        users = data
        tableView.reloadData()
    }
    
    func failure(message: String) {
        self.presentAlert(title: "불러오기 실패", message: message)
    }
}

extension FollowerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell") as! FollowerTableViewCell
        let user = users[indexPath.row]
        
        cell.shopNameLabel.text = user.shop_name
        if let imagePath = user.image {
            let url = URL(string: Constant.IMAGE_URL + imagePath)
            cell.shopImageView.kf.setImage(with: url)
        }
        cell.followerCountLabel.text = String(user.countFollower)
        cell.itemCountLabel.text = String(user.countItem)
        return cell
    }
}
