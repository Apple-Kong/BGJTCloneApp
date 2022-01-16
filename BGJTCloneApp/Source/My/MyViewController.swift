//
//  MyViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit

class MyViewController: UIViewController {
    
    

    
    @IBAction func wishListButton(_ sender: UITapGestureRecognizer) {
        
        let vc = UIStoryboard(name: "InterestStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "InterestViewController") as! InterestViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var numOfItemLabel: UILabel!
    @IBOutlet weak var talbeView: UITableView!
    
    
    @IBAction func homeButtonTap(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    var items: [Int] = [1]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        inquiryButton.roundedBorder()
        inquiryButton.layer.cornerRadius = 20
        shopImageView.maskToCircle()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let buttonStrings = ["edit", "filter", "plus"]
        var buttons: [UIBarButtonItem] = []
        for string in buttonStrings {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 24))
            //set image for button
            button.setImage(UIImage(named: string)?.resizeImage(size: CGSize(width: 24, height: 24)), for: .normal)
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


extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        //데이터 연결
        
        
        
        return cell
    }
    
    
}


