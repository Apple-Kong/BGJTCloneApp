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
    let itemEditManager = ItemEditManager()
    
    var showingItems: [SellListResult] = []
    var allSellingItems: [SellListResult] = []
    
    var nowShowing = "Sale" {
        didSet {
            
            // nowShowing이 변경됨에 따라. 문자열에 따라 보여지는 아이템의 항목을 필터링
            
            var temp: [SellListResult] = []
            
            for item in allSellingItems {
                if item.sale == nowShowing {
                    temp.append(item)
                }
            }
            
            showingItems = temp
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var saleBar: UIView!
    @IBAction func Sale(_ sender: UIButton) {
        nowShowing = "Sale"
        saleBar.isHidden = false
        reservedBar.isHidden = true
        soldBar.isHidden = true
    }
    @IBOutlet weak var reservedBar: UIView!
    @IBAction func Reserved(_ sender: UIButton) {
        nowShowing = "Reserved"
        
        saleBar.isHidden = true
        reservedBar.isHidden = false
        soldBar.isHidden = true
    }
    
    @IBOutlet weak var soldBar: UIView!
    @IBAction func Sold(_ sender: UIButton) {
        nowShowing = "Sold"
        saleBar.isHidden = true
        reservedBar.isHidden = true
        soldBar.isHidden = false
    }
    
    @IBAction func wishListButton(_ sender: UITapGestureRecognizer) {
        
        let vc = UIStoryboard(name: "InterestStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "InterestViewController") as! InterestViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var eventIndicatorLabel: UILabel!
    
    @IBOutlet weak var eventIndicaatorView: UIView!
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
        
        itemEditManager.delegate = self
       
        eventIndicaatorView.roundedBorder()
        eventIndicaatorView.layer.borderColor = UIColor.systemGray5.cgColor
        eventIndicaatorView.maskToCircle()
        
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

extension MyViewController: SellListDelegate {
    func didFetched(data: [SellListResult]) {
      
        self.allSellingItems = data
        
        var temp: [SellListResult] = []
        
        for item in allSellingItems {
            if item.sale == nowShowing {
                temp.append(item)
            }
        }
        
        showingItems = temp
        
        
        self.tableView.reloadData()
    }
    
    func sellListFailure(message: String) {
        self.presentAlert(title: "판매 목록 에러", message: message)
        self.dismissIndicator()
    }
}


extension MyViewController: ItemEditDelegate {
    func edit(itemID: Int) {
         //미구현
        
    }
    
    func changeCondition(itemID: Int) {
        
        presentConditionModalViewController(index: itemID)
        
    }
    
    func delete(itemID: Int) {
        itemEditManager.delete(itemID: itemID)
        self.dealListDataManager.fetchSellList()
    }
    
    
}

extension MyViewController: ButtonInsideCellDelegate {
    func buttonTapped(index: Int) {
        presentEditModalViewController(index: index)
    }
    
    
}

extension MyViewController: ChangeConditionDelegate {
    func reserved(itemID: Int) {
        itemEditManager.changeCondition(itemID: itemID, statusNum: 2)
        
    }
    
    func confirmed(itemID: Int) {
        itemEditManager.changeCondition(itemID: itemID, statusNum: 3)
    }
    
    
}


extension MyViewController {
    func didChanged() {
        dealListDataManager.fetchSellList()
    }
}

//MARK: - half modalView 띄우기
extension MyViewController: UIViewControllerTransitioningDelegate {
        // ...
    
    //half modal view 띄우는 메서드
    private func presentConditionModalViewController(index: Int) {
        let storyboard = UIStoryboard(name: "MyStoryBoard", bundle: nil)
        guard let changeModalViewController = storyboard.instantiateViewController(withIdentifier: "ChangeConditionViewController") as? ChangeConditionViewController else {
            return
        }
            
        
        
        changeModalViewController.delegate = self
        changeModalViewController.itemID = index
        
        changeModalViewController.modalPresentationStyle = .custom
        changeModalViewController.transitioningDelegate = self
        present(changeModalViewController, animated: true, completion: nil)
    }
    
    
    
    //half modal view 띄우는 메서드
    private func presentEditModalViewController(index: Int) {
        let storyboard = UIStoryboard(name: "MyStoryBoard", bundle: nil)
        guard let editModalViewController = storyboard.instantiateViewController(withIdentifier: "ItemEditViewController") as? ItemEditViewController else {
            return
        }
            
        editModalViewController.delegate = self
        editModalViewController.itemID = showingItems[index].item_id
        
        editModalViewController.modalPresentationStyle = .custom
        editModalViewController.transitioningDelegate = self
        present(editModalViewController, animated: true, completion: nil)
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        if presented is ChangeConditionViewController {
            let halfModalPC = HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
            
            halfModalPC.proportianoalYPosition = 0.7
            halfModalPC.proportionalHeight = 0.5
            
            return halfModalPC
        } else {
            let halfModalPC = HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
            
            halfModalPC.proportianoalYPosition = 0.5
            halfModalPC.proportionalHeight = 0.6
            
            return halfModalPC
        }
    }
}


extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableViewHeightConstraint.constant = CGFloat(130 * showingItems.count)
        self.numOfItemLabel.text = "\(showingItems.count)개"
        
        
  
        return showingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.selectionStyle = .none
        
        let sellingItem = showingItems[indexPath.row]
        //데이터 연결
        if let imagePath = sellingItem.image_path {
            let url = URL(string: Constant.IMAGE_URL + imagePath)
            cell.itemImageView.kf.setImage(with: url)
        }
        cell.index = indexPath.row
        
        cell.bgPayBadgeView.isHidden = sellingItem.safety_pay == 0 ? true : false
        cell.delegate = self
        cell.titleLabel.text = sellingItem.title
        cell.priceLabel.text = String(sellingItem.price).insertComma
        cell.createAtLabel.text = sellingItem.created_at.stringToIntervalDateString()
        
        return cell
    }
}


