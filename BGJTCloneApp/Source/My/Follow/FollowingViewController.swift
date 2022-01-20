//
//  FollowingViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import UIKit
import Alamofire
import Kingfisher


class FollowingViewController: UIViewController {
    
    let followListDataManager = FollowingListDataManager()
    
    @IBAction func backButtonTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var shops: [FollowingResult] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followListDataManager.followingDelegate = self
        followListDataManager.fetchFollowingList()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension FollowingViewController: FollowingListDelegate {
    func didfetched(data: [FollowingResult]) {
        self.shops = data
        self.tableView.reloadData()
    }
    
    func failure(message: String) {
        self.presentAlert(title: "불러오기 실패", message: message)
    }
}



extension FollowingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingListTableViewCell") as! FollowingListTableViewCell
        let shop = shops[indexPath.row]
        
        
        
        cell.shopNameLabel.text = shop.shopName
        cell.itemCountLabel.text = String(shop.howManyItem)
        cell.followerCountLabel.text = String(shop.howManyFollowers)
        
        
        //상점이미지를 안받아옴
//        let url = URL(string: Constant.IMAGE_URL + shop.)
//        cell.shopImageView.image
        
        let items = shop.getItemResult
        
        for (index, item) in items.enumerated() {
            let url = URL(string: Constant.IMAGE_URL + item.image_path)
            
            switch index {
            case 0:
                cell.imageView1.kf.setImage(with: url)
                cell.priceLabel1.text = String(item.price)
                    .insertComma
            case 1:
                cell.imageView2.kf.setImage(with: url)
                cell.priceLabel2.text = String(item.price)
                    .insertComma
            case 2:
                cell.imageView3.kf.setImage(with: url)
                cell.priceLabel3.text = String(item.price)
                    .insertComma
            default:
                print("nothing")
            }
        }
        
        
        return cell
    }
    
}

