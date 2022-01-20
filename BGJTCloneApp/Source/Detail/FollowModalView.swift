//
//  FollowModalView.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/19.
//

import UIKit


class FollowModalView: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var alertView: UIView!
    
    var delegate: FollowAlertDelegate?
    var index = 0
    @IBAction func yesButtonTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false) {
            self.delegate?.yesButtonTapped()
        }
    }
    
    
    @IBAction func noButtonTap(_ sender: Any) {
        self.dismiss(animated: false) {
            self.delegate?.noButtonTapped()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 20
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        UIView.animate(withDuration: 0.2,
           delay: 0,
            options: .curveLinear,
           animations: {
            self.alertView.transform = CGAffineTransform.identity
        },
            completion: { Void in()  }
        )
    }
}

protocol FollowAlertDelegate {
    func yesButtonTapped()
    func noButtonTapped()
}
