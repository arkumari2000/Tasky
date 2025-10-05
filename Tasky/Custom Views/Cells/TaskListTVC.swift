//
//  TaskListTVC.swift
//  Tasky
//
//  Created by Archana Kumari on 19/08/25.
//

import UIKit

class TaskListTVC: UITableViewCell {
    
    static let reuseId = "TaskListTVC"
    
    let cellPadding : CGFloat = 10
    
    let taskListLabel = TaskyBodyLabel(frame: .zero)
    let symbolImageView = TaskySymbolImageView(frame: .zero)
    let taskCountLabel = TaskyBodyLabel(frame: .zero)
    let arrowSymbol = TaskySymbolImageView(with: UIImage(systemName: "chevron.right")?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal), backgroundColor: nil)
    
    let spacerView = UIView()
    
    let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: TaskList) {
        if let symbolImage = UIImage(systemName: data.icon) {
            symbolImageView.image = symbolImage.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
        }
        
        taskListLabel.text = data.title
        
        taskCountLabel.text = String(data.tasks.count)
    }
    
    func setupViews() {
        spacerView.backgroundColor = .clear    // invisible spacer
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        hStackView.addArrangedSubview(symbolImageView)
        hStackView.addArrangedSubview(taskListLabel)
        hStackView.addArrangedSubview(spacerView)
        hStackView.addArrangedSubview(taskCountLabel)
        hStackView.addArrangedSubview(arrowSymbol)
        
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: topAnchor, constant: cellPadding),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellPadding),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cellPadding),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -cellPadding),
            
            symbolImageView.widthAnchor.constraint(equalToConstant: 40),
            symbolImageView.heightAnchor.constraint(equalToConstant: 40),
            
            arrowSymbol.widthAnchor.constraint(equalToConstant: 20),
            arrowSymbol.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
}
