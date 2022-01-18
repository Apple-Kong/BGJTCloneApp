//
//  DetailTableViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/18.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var ItemImageVIew: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
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
