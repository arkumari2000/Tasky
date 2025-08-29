//
//  AddButton.swift
//  Tasky
//
//  Created by Rishabh Kumar on 24/08/25.
//

import UIKit

class TaskyAddButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(title : String,
         image: UIImage?,
         type: UIButton.ButtonType = .system) {
        super.init(frame: .zero)

        self.init(type: type)
        self.setTitle(title, for: .normal)
        self.setImage(image, for: .normal)

        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
