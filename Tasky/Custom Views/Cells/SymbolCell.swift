//
//  SymbolCell.swift
//  Tasky
//
//  Created by Archana Kumari on 12/08/25.
//

import UIKit

class SymbolCell: UICollectionViewCell {
    
    static let reuseId = "SymbolCell"
    
    let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSymbol(image: UIImage) {
        symbolImageView.image = image
    }
    
    func configureCell() {
        contentView.addSubview(symbolImageView)
        NSLayoutConstraint.activate([
            symbolImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            symbolImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbolImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            symbolImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8)
        ])
    }
    
}
