//
//  ItemEditViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/18.
//

import UIKit

class ItemEditViewController: UIViewController {
    
    
    
    
    
    @IBOutlet var editButtonTapped: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var itemID = 0
    var delegate: ItemEditDelegate?
    
    @IBAction func editButtonTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true) {
            self.delegate?.edit(itemID: self.itemID)
        }
    }
    @IBAction func chageConditionButtonTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true) {
            self.delegate?.changeCondition(itemID: self.itemID)
        }
    }
    @IBAction func deleteButtonTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true) {
            self.delegate?.delete(itemID: self.itemID)
        }
    }
}


protocol ItemEditDelegate {
    func edit(itemID: Int)
    func changeCondition(itemID: Int)
    func delete(itemID: Int)
}
