//
//  TaskyButton.swift
//  Tasky
//
//  Created by Archana Kumari on 21/08/25.
//

import UIKit

class TaskyButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor,
         title: String,
         font: UIFont? = nil,
         titleColor: UIColor? = nil,
         cornerRadius: CGFloat? = nil) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure(font: font,
                  titleColor: titleColor,
                  cornerRadius: cornerRadius)
    }
    
    private func configure(font: UIFont?,
                           titleColor: UIColor?,
                           cornerRadius: CGFloat?) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = cornerRadius ?? 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = font ?? UIFont.preferredFont(forTextStyle: .headline)
    }
}
