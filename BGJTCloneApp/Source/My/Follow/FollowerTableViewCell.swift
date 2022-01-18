//
//  FollowerTableViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shopImageView.maskToCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
