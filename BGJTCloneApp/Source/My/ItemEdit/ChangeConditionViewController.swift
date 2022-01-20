//
//  ChangeConditionViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/19.
//

import UIKit

class ChangeConditionViewController: UIViewController {
 
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var itemID = 0
    var delegate: ChangeConditionDelegate?
    
    @IBAction func editButtonTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true) {
            self.delegate?.reserved(itemID: self.itemID)
        }
    }
    @IBAction func chageConditionButtonTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true) {
            self.delegate?.confirmed(itemID: self.itemID)
        }
    }
}

protocol ChangeConditionDelegate {
    func reserved(itemID: Int)
    func confirmed(itemID: Int)
}
