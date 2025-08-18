//
//  HeaderCell.swift
//  Tasky
//
//  Created by Archana Kumari on 17/08/25.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    static let reuseId = "HeaderCell"
    
    let titleLabel = TaskyTitleLabel(textAlignment: .left, fontSize: 16)
    
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
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
