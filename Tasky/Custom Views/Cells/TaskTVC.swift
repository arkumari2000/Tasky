//
//  TaskTVC.swift
//  Tasky
//
//  Created by Archana Kumari on 21/08/25.
//

import UIKit

protocol TaskTVCDelegate: AnyObject {
    func didTapButton(in cell: TaskTVC)
}

class TaskTVC: UITableViewCell {
    
    static let reuseId = "TaskTVC"
    
    weak var delegate: TaskTVCDelegate?
    
    let cellSpacing: CGFloat = 5
    
    let radioButton = TaskyRadioButton(frame: .zero)
    let taskTitleLabel = TaskyBodyLabel(frame: .zero)
    
    let hStack: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(with tasktitle: String, isCompleted: Bool = false) {
        
        taskTitleLabel.text = tasktitle
        if isCompleted {
            // Create attributed string with strikethrough attribute
            let attributedString = NSAttributedString(
                string: tasktitle,
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor.secondaryLabel
                ]
            )
            taskTitleLabel.attributedText = attributedString
        }
        radioButton.isChecked = isCompleted
    }
    
    func configureCell() {
        hStack.addArrangedSubview(radioButton)
        hStack.addArrangedSubview(taskTitleLabel)
        
        contentView.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: cellSpacing),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -cellSpacing)
        ])
    }

}
