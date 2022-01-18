//
//  MyTableViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var bgPayBadgeView: UIImageView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveryButton: UIButton!
    var index: Int = 0
    var delegate: ButtonInsideCellDelegate?
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(index: index)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.deliveryButton.layer.borderWidth = 1
        self.deliveryButton.layer.borderColor = UIColor.black.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
