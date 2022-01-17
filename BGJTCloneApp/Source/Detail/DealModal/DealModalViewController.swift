//
//  DealModalViewController.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import UIKit

class DealModalViewController: UIViewController {
    
    var delegate: DealModalDelegate?
    
    @IBAction func dismissButtonTap(_ sender: UIButton) {
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
    @IBAction func deliveryButtonTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true) {
            self.delegate?.delivery()
        }
    }
    
    @IBAction func directButtonTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true) {
            self.delegate?.direct()
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


protocol DealModalDelegate {
    func delivery()
    func direct()
}
