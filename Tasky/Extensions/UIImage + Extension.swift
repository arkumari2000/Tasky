//
//  UIImageView + Extension.swift
//  Tasky
//
//  Created by Archana Kumari on 18/08/25.
//

import Foundation
import UIKit

extension UIImage {
    
    func withPadding(_ padding: CGFloat, backgroundColor: UIColor = .clear, tintColor: UIColor? = nil) -> UIImage? {
        let newSize = CGSize(width: self.size.width + 2*padding,
                             height: self.size.height + 2*padding)
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(CGRect(origin: .zero, size: newSize))

        let imageToDraw: UIImage
        if let tintColor = tintColor {
            // Render the image with tint color
            imageToDraw = self.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        } else {
            imageToDraw = self.withRenderingMode(.alwaysOriginal)
        }

        imageToDraw.draw(in: CGRect(x: padding, y: padding,
                                    width: self.size.width, height: self.size.height))

        let paddedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return paddedImage
    }

    
    /// Resizes the image by a given multiplier.
    /// - Parameter multiplier: The factor by which to scale the image (e.g., 0.5 for half size).
    /// - Returns: A new UIImage scaled by the multiplier.
    func scaled(by multiplier: CGFloat) -> UIImage? {
        // Calculate the new size based on the multiplier
        let newSize = CGSize(width: size.width * multiplier, height: size.height * multiplier)
        
        // Begin an image context with the new size
        // The 'scale' parameter (last argument) is set to 0.0 to use the device's main screen scale.
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        // Draw the original image into the new context within the calculated rectangle
        draw(in: CGRect(origin: .zero, size: newSize))
        
        // Get the new image from the current context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the image context
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
