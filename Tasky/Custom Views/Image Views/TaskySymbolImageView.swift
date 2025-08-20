//
//  TaskySymbolImageView.swift
//  Tasky
//
//  Created by Archana Kumari on 19/08/25.
//

import UIKit

class TaskySymbolImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(with image: UIImage?, backgroundColor: UIColor? = .clear) {
        super.init(frame: .zero)
        self.image = image
        self.backgroundColor = backgroundColor
        configureImageView()
    }
    
    func configureImageView() {
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = false
        clipsToBounds = true
    }

}
