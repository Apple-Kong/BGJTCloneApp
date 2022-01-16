//
//  RecommendCollectionViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    var delegate: WishDelegate?
    var index = 0
   
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var BGpayImageView: UIImageView!
    @IBOutlet weak var wishButton: UIButton!
    
    
    
    @IBAction func wishButton(_ sender: UIButton) {
        self.delegate?.wishButtonTapped(index: index)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

