//
//  ImageCollectionViewCell.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/09.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var deleteView: UIView!
    @IBAction func deleteButtonTap(_ sender: UIButton) {
    }
    
}


protocol deleteDelegate {
    func deleteButtonTapped()
}
