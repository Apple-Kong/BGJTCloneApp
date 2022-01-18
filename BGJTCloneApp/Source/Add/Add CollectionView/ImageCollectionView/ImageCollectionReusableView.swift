//
//  ImageCollectionReusableView.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/10.
//

import UIKit

class ImageCollectionReusableView: UICollectionReusableView {
        
    
    
    var delegate: HeaderDelegate?
    
    @IBAction func addImageButton(_ sender: UIButton) {
        
        delegate?.addButtonTapped()
    }
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var countLabel: UILabel!
    

}



protocol HeaderDelegate {

    // 2. create a function that will do something when the header is tapped
    func addButtonTapped()
}


