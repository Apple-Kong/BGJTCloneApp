//
//  AllTableViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/12.
//

import UIKit

class AllTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
