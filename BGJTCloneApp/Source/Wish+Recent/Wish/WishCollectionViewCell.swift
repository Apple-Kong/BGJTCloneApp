//
//  WishCollectionViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/13.
//

import UIKit

class WishCollectionViewCell: UICollectionViewCell {
    
    var deleagte: WishDelegate?
    
    var index: Int = 0
    
    @IBOutlet weak var itemIamgeView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var safetyPayView: UIImageView!
    
    @IBAction func wishButtonTap(_ sender: UIButton) {
        self.deleagte?.wishButtonTapped(index: self.index)
    }
}

