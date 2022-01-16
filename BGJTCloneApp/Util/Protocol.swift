//
//  Protocol.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/16.
//

import Foundation


protocol WishDelegate {
    func wishButtonTapped(index: Int)
}

protocol ButtonInsideCellDelegate {
    func buttonTapped(index: Int)
}
