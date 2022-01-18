//
//  DealViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/14.
//

import UIKit

class DealViewController: UIViewController {
    
    var isAgree: Bool = false {
        didSet {
            if isAgree {
                agreeImageView.tintColor = UIColor(named: "badge")
            } else {
                agreeImageView.tintColor = .systemGray4
            }
        }
    }
    

    var itemID: Int?
    var dealType = 0
    var address = "경기도 부천시 경인로 134번길 16"
    var pay = "카카오페이"
    
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var destinationView: UIView!
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var dealPriceView: UIView!
    @IBOutlet weak var dealMethodView: UIView!
    @IBOutlet weak var agreeImageView: UIImageView!
    @IBAction func AgreeButtonTapped(_ sender: UITapGestureRecognizer) {
        
        isAgree.toggle()
    }
    @IBOutlet weak var pointViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pointLabel: UILabel!
    

    @IBOutlet weak var dealButton: UIButton!
    @IBAction func dealButtonTap(_ sender: UIButton) {
        
        //결제 메서드 실행
    }
    
    @IBOutlet weak var pointInputView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.title = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .black
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.dealType == 0 {
            topLabel.text = "직거래, 안전결제로"
            deliveryLabel.isHidden = true
            destinationView.isHidden = true
            requestView.isHidden = true
            pointViewTopConstraint.constant = 50
            
        }
        
        
        dealButton.layer.masksToBounds = true
        dealButton.layer.cornerRadius = 5
        

        destinationView.roundedBorder(radius: 5, borderWidth: 1, color: .systemGray5)
        requestView.roundedBorder(radius: 5, borderWidth: 1, color: .systemGray5)
        pointInputView.roundedBorder(radius: 5, borderWidth: 1, color: .systemGray5)
        dealPriceView.roundedBorder(radius: 5, borderWidth: 1, color: .systemGray5)
        dealMethodView.roundedBorder(radius: 5, borderWidth: 1, color: .systemGray5)
        
        
    }
}
