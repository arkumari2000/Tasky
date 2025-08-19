//
//  TaggedTaskListCell.swift
//  Tasky
//
//  Created by Archana Kumari on 18/08/25.
//

import UIKit

struct TaggedTaskListData {
    var symbolImage: UIImage?
    var taskCount: Int = 0
    var label: String?
}

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
    
    let symbolImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
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
    
    func configureData(with data: TaggedTaskListData) {
        if let symbolImage = data.symbolImage {
            let tintedImage = symbolImage.withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
            symbolImageView.image = tintedImage
        }
        
        if let labelText = data.label {
            label.text = labelText
        }
        
        taskCount.text = String(data.taskCount)
    }
    
    func configureView() {
        contentView.layer.cornerRadius = 5
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
