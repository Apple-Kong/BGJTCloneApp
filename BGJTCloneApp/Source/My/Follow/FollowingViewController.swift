//
//  FollowingViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import UIKit
import Alamofire


class FollowingViewController: UIViewController {
    
    let followListDataManager = FollowingListDataManager()
    
    @IBAction func backButtonTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followListDataManager.fetchFollowingList()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}



extension FollowingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingListTableViewCell") as! FollowingListTableViewCell
        
        return cell
    }
    
}

