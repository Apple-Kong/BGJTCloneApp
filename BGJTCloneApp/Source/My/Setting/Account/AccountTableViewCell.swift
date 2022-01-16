//
//  AccountTableViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    
    var index: Int = 0
    var delegate: ButtonInsideCellDelegate?
    

    @IBAction func editButtonTap(_ sender: UIButton) {
        delegate?.buttonTapped(index: index)
        
    }
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    override func awakeFromNib() {
        
        accountImageView.maskToCircle()
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
