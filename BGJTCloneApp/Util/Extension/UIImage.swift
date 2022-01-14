//
//  UIImage.swift
//  BGJTCloneApp
//
//  Created by GOngTAE on 2022/01/14.
//

import UIKit

//MARK: - 버튼에 이미지 사이즈가 화면에서 출력되는 사이즈와 동일하지 않으면 프레임을 무시하고 출력되는 현상 해결.
//그래서 이를 위해 이미지를 resize할 필요가 있습니다. 그래서 아래와 같은 resizeImage(size:)와 같은 메소드로 이미지 사이즈를 우선 조정하고 이를 버튼에 적용해볼 수 있습니다.
extension UIImage {
  func resizeImage(size: CGSize) -> UIImage {
    let originalSize = self.size
    let ratio: CGFloat = {
        return originalSize.width > originalSize.height ? 1 / (size.width / originalSize.width) :
                                                          1 / (size.height / originalSize.height)
    }()

    return UIImage(cgImage: self.cgImage!, scale: self.scale * ratio, orientation: self.imageOrientation)
  }
}
