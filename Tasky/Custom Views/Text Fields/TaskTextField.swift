//
//  TaskTextField.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class TaskTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholderText: String,
         cornerRadius: CGFloat? = nil,
         alignment: NSTextAlignment? = nil,
         textFont: UIFont? = nil,
         background: UIColor? = nil) {
        super.init(frame: .zero)
        placeholder = placeholderText
        configure(cornerRadius: cornerRadius,
                  alignment: alignment,
                  textFont: textFont,
                  background: background)
    }
    
    private func configure(cornerRadius: CGFloat?,
                           alignment: NSTextAlignment?,
                           textFont: UIFont?,
                           background: UIColor?) {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = cornerRadius ?? 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = alignment ?? .center
        font = textFont ?? UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = background ?? .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
    }

}
