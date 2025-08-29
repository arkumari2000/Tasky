//
//  AddButton.swift
//  Tasky
//
//  Created by Rishabh Kumar on 24/08/25.
//

import UIKit

class TaskyAddButton:UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(title:String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        layer.cornerRadius=2
        translatesAutoresizingMaskIntoConstraints=false
        self.setTitleColor(.orange, for: .normal)
        self.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        
    }
}
