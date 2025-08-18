//
//  UIImageView + Extension.swift
//  Tasky
//
//  Created by Archana Kumari on 18/08/25.
//

import Foundation
import UIKit

extension UIImage {

    func withPadding(_ padding: CGFloat, backgroundColor: UIColor = .clear) -> UIImage? {
        let newSize = CGSize(width: self.size.width + 2*padding,
                             height: self.size.height + 2*padding)
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(CGRect(origin: .zero, size: newSize))
        self.draw(in: CGRect(x: padding, y: padding,
                             width: self.size.width, height: self.size.height))
        let paddedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return paddedImage
    }

}
