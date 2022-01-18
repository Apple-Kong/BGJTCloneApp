//
//  FollowerViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import UIKit

class FollowerViewController: UIViewController {
    
    let followListDataManager = FollowingListDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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


extension FollowerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerTableViewCell") as! FollowerTableViewCell
        
        return cell
    }
}
