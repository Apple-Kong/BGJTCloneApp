//
//  ImageCollectionViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    var index = 0
    var delegate: DeleteDelegate?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var deleteView: UIView!
    
    
    @IBAction func deleteButtonTap(_ sender: UIButton) {
        delegate?.deleteButtonTapped(index: index)
      
    }
    
}


protocol DeleteDelegate {
    func deleteButtonTapped(index: Int)
}
