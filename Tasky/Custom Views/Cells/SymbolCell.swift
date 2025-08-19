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
        imageView.backgroundColor = .systemGray6
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
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
        let paddedImage = image.withPadding(10)
        symbolImageView.image = paddedImage
        DispatchQueue.main.async {
            self.symbolImageView.layer.cornerRadius = self.symbolImageView.frame.height/2
        }
    }
    
    func configureCell() {
        contentView.addSubview(symbolImageView)
        NSLayoutConstraint.activate([
            symbolImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            symbolImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbolImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            symbolImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9)
        ])
    }
    
}
