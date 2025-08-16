//
//  UIHelpers.swift
//  Tasky
//
//  Created by Archana Kumari on 12/08/25.
//

import Foundation
import UIKit

struct UIHelper {
    
    static func createSixColumnFlowlayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let padding: CGFloat = 12
        let minimumInteritemSpacing: CGFloat = 5
        let availableWidth = width - (padding * 2) - (minimumInteritemSpacing * 5)
        let itemWidth = availableWidth / 6
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        
        return flowLayout
    }
}
