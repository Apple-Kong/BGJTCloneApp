//
//  TagCollectionViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/12.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    var index: Int = 0
    var delegate: TagCellDelegate?
    
    
    @IBAction func deleteButtonTap(_ sender: UIButton) {
        delegate?.cellDidSelected(index: self.index)

    }
    @IBOutlet weak var deleteButtonTap: UIButton!
}


protocol TagCellDelegate {
    func cellDidSelected(index: Int)
}
