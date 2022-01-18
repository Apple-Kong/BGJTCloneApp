//
//  MyViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit
import Kingfisher

class MyViewController: UIViewController {
    
    let dealListDataManager = DealListDataManager()
    let myDataManager = MyDataManager()
    
    
    var sellingItems: [SellListResult] = []
    
    @IBAction func wishListButton(_ sender: UITapGestureRecognizer) {
        
        let vc = UIStoryboard(name: "InterestStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "InterestViewController") as! InterestViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    
    @IBOutlet weak var wishCountLabel: UILabel!
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var numOfItemLabel: UILabel!
    @IBOutlet weak var talbeView: UITableView!
    
    
    @IBAction func homeButtonTap(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    var items: [Int] = [1,1,1,1,1,1,1,1,1]
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터 요청
        myDataManager.delegate = self
        self.showIndicator()
        myDataManager.fetch()
        
        //상품 데이터 요청
        dealListDataManager.sellDelegate = self
        dealListDataManager.fetchBuyList()
        dealListDataManager.fetchSellList()
        
        //상점 문의 버튼
        inquiryButton.roundedBorder()
        inquiryButton.maskToCircle()
        shopImageView.maskToCircle()
        
        numOfItemLabel.text = "\(items.count)개"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let buttonStrings = ["my_gear", "my_bell", "my_p"]
        var buttons: [UIBarButtonItem] = []
        for string in buttonStrings {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
            //set image for button
            button.setImage(UIImage(named: string)?.resizeImage(size: CGSize(width: 28, height: 28)), for: .normal)
            //add function for button
            button.addTarget(self, action: #selector(settingButtnPressed), for: .touchUpInside)
            //set frame
            buttons.append(UIBarButtonItem(customView: button))
        }
        self.navigationItem.rightBarButtonItems = buttons
        //assign button to navigationbar

    }
    
    @objc func settingButtnPressed() {
        let vc = UIStoryboard(name: "SettingStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyViewController: SellListDelegate {
    func didFetched(data: [SellListResult]) {
      
        
        for item in data {
            self.sellingItems.append(item)
        }
        self.tableView.reloadData()
    }
    
    func sellListFailure(message: String) {
        self.presentAlert(title: "판매 목록 에러", message: message)
        self.dismissIndicator()
    }
}

extension MyViewController {
    func didFetched(data: MyResponse.MyResult) {
        // 데이터 UI 반영
        shopNameLabel.text = data.shop_name
        
        if let imagePath = data.user_image {
            let urlString = Constant.IMAGE_URL + imagePath
            guard let url = URL(string: urlString) else {return}
            shopImageView.kf.setImage(with: url)
        }
    
        wishCountLabel.text = String(data.wish_count)
        reviewCountLabel.text = String(data.review_count)
        followerCountLabel.text = String(data.follower_count)
        followingCountLabel.text = String(data.following_count)
        
        

        self.dismissIndicator()
        
        
    }
    
    func failure(message: String) {
        self.presentAlert(title: "마이페이지 요청 실패", message: message)
        self.dismissIndicator()
    }
}


extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableViewHeightConstraint.constant = tableView.contentSize.height + 600
        self.numOfItemLabel.text = "\(sellingItems.count)개"
        return sellingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        let sellingItem = sellingItems[indexPath.row]
        //데이터 연결
        if let imagePath = sellingItem.image_path {
            let url = URL(string: Constant.IMAGE_URL + imagePath)
            cell.itemImageView.kf.setImage(with: url)
        }
       
        cell.titleLabel.text = sellingItem.title
        cell.priceLabel.text = String(sellingItem.price)
        
        
        return cell
    }
}


