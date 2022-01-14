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
    
    
    @IBAction func dealButtonTap(_ sender: UIButton) {
        
        //결제 메서드 실행
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.title = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .black
    }
    override func viewDidLoad() {
        

        destinationView.roundedBorder(radius: 10, borderWidth: 1, color: .systemGray5)
        requestView.roundedBorder(radius: 10, borderWidth: 1, color: .systemGray5)
        pointView.roundedBorder(radius: 10, borderWidth: 1, color: .systemGray5)
        dealPriceView.roundedBorder(radius: 10, borderWidth: 1, color: .systemGray5)
        dealMethodView.roundedBorder(radius: 10, borderWidth: 1, color: .systemGray5)
        
        super.viewDidLoad()
    }
}
