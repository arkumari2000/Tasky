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
        let padding: CGFloat = 2
        let minimumItemSpacing: CGFloat = 0
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 7
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.estimatedItemSize = .zero
        
        return flowLayout
    }
}
