//
//  FollowingListTableViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/17.
//

import UIKit

class FollowingListTableViewCell: UITableViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var priceLabel1: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var priceLabel2: UILabel!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var priceLabel3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shopImageView.maskToCircle()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
