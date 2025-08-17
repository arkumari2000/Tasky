//
//  HeaderCell.swift
//  Tasky
//
//  Created by Archana Kumari on 17/08/25.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    static let reuseId = "HeaderCell"
    
    let titleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(textAlignment: NSTextAlignment, text: String) {
        titleLabel.textAlignment = textAlignment
        titleLabel.text = text
    }
    
    func configureLabel() {
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
