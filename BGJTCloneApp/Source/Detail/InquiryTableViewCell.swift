//
//  InquiryTableViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/19.
//

import UIKit

class InquiryTableViewCell: UITableViewCell {
    
    var delegate: InquiryViewController?
    var index: Int = 0

    @IBOutlet weak var createAtLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shopImageView.maskToCircle()
    }
    @IBAction func replyButtonTap(_ sender: UIButton) {
        delegate?.replyButtonTap(index: index)
    }
    
    @IBAction func deleteButtonTap(_ sender: UIButton) {
        delegate?.deleteButtonTap(index: index)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

