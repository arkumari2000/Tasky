//
//  TaggedTaskListCell.swift
//  Tasky
//
//  Created by Archana Kumari on 18/08/25.
//

import UIKit

class TaggedTaskListCell: UICollectionViewCell {
    
    static let reuseId = "TaggedTaskListCell"
    
    let vStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        return stackView
    }()

    let hStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let symbolImageView = TaskySymbolImageView(frame: .zero)
    
    let taskCount = TaskyTitleLabel(textAlignment: .right, fontSize: 30)
    
    let label = TaskyTitleLabel(textAlignment: .left, fontSize: 20, textColor: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureStackViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(with data: TaskList) {
        if let symbolImage = UIImage(systemName: data.icon) {
            let tintedImage = symbolImage.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
            symbolImageView.image = tintedImage
        }
        
        label.text = data.title
        
        taskCount.text = String(data.tasks.count)
    }
    
    func configureView() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemGray6
    }
    
    func configureStackViews() {
        hStackView.addArrangedSubview(symbolImageView)
        hStackView.addArrangedSubview(taskCount)
        
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(label)
        
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vStackView)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 50),
            symbolImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
