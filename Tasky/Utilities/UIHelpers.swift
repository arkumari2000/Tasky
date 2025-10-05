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
        flowLayout.headerReferenceSize = CGSize(width: view.frame.size.width, height: 40)
        
        return flowLayout
    }
    
    static func createColumnFlowlayour(withColumns columns: CGFloat,
                                       in view: UIView,
                                       padding: CGFloat,
                                       spacing: CGFloat,
                                       maxSize: CGSize? = UICollectionViewFlowLayout.automaticSize) -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let availableWidth = width - (padding * 2) - (spacing * (columns-1))
        let itemWidth = availableWidth / columns
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 100)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumInteritemSpacing = spacing
        
        return flowLayout
    }
    
    /// There is an issue with this method, it is not working properly.
    /// Will visit this method soon
    static func calculateMaxCellSize(for dataList: [TaskList], fixedWidth: CGFloat) -> CGSize {
        var maxSize = CGSize(width: 0, height: 0)

        for data in dataList {
            // Create an instance of your cell with a fixed width and large arbitrary height
            let cell = TaggedTaskListCell(frame: CGRect(x: 0, y: 0, width: fixedWidth, height: 1000))
            // Configure the cell with the data
            cell.configureData(with: data)

            // Trigger layout pass
            cell.setNeedsLayout()
            cell.layoutIfNeeded()

            // Calculate fitting size for the contentView with fixed width and flexible height
            let size = cell.contentView.systemLayoutSizeFitting(
                CGSize(width: fixedWidth, height: UIView.layoutFittingCompressedSize.height),
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )

            // Track the max height and width (width should be fixed, but included for safety)
            if size.height > maxSize.height {
                maxSize.height = size.height
            }
            if size.width > maxSize.width {
                maxSize.width = size.width
            }
        }
        return maxSize
    }

}
