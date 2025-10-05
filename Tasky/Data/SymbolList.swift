//
//  SymbolList.swift
//  Tasky
//
//  Created by Archana Kumari on 12/08/25.
//

import Foundation
import UIKit

struct SystemImage {
    let image: UIImage?
    let systemName: String
}

struct SymbolList {
    static let allSymbols = [
        SystemImage(image: UIImage(systemName: "figure.walk"), systemName: "figure.walk"),
        SystemImage(image: UIImage(systemName: "pencil"), systemName: "pencil"),
        SystemImage(image: UIImage(systemName: "book"), systemName: "book"),
        SystemImage(image: UIImage(systemName: "dumbbell"), systemName: "dumbbell"),
        SystemImage(image: UIImage(systemName: "bell"), systemName: "bell"),
        SystemImage(image: UIImage(systemName: "sun.min"), systemName: "sun.min"),
        SystemImage(image: UIImage(systemName: "toilet"), systemName: "toilet"),
        SystemImage(image: UIImage(systemName: "cloud.rain"), systemName: "cloud.rain"),
        SystemImage(image: UIImage(systemName: "signature"), systemName: "signature"),
        SystemImage(image: UIImage(systemName: "textformat"), systemName: "textformat"),
        SystemImage(image: UIImage(systemName: "infinity"), systemName: "infinity")
    ]
}
