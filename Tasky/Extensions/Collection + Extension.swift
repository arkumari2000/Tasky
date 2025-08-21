//
//  Collection + Extension.swift
//  Tasky
//
//  Created by Archana Kumari on 21/08/25.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
