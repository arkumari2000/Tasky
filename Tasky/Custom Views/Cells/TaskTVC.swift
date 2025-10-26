//
//  TaskTVC.swift
//  Tasky
//
//  Created by Archana Kumari on 21/08/25.
//

import UIKit

class TaskTVC: UITableViewCell {
    
    static let reuseId = "TaskTVC"
    
    let cellSpacing: CGFloat = 5
    
    let radioButton = TaskyRadioButton(frame: .zero)
    let taskTitleLabel = TaskyBodyLabel(frame: .zero)
    let dueDateLabel = TaskyBodyLabel(frame: .zero)
    
    let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
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
    
    func setData(with task: TaskItem) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dueDateLabel.text = dateFormatter.string(from: task.dueDate)
        
        taskTitleLabel.text = task.title
        radioButton.isChecked = false
        
        if task.isCompleted {
            setCompletedTask(with: task)
        }
    }
    
    func setCompletedTask(with task: TaskItem) {
        // Create attributed string with strikethrough attribute
        let attributedString = NSAttributedString(
            string: task.title,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.secondaryLabel
            ]
        )
        taskTitleLabel.attributedText = attributedString
        
        radioButton.isChecked = true
    }
    
    func configureCell() {
        vStack.addArrangedSubview(taskTitleLabel)
        vStack.addArrangedSubview(dueDateLabel)
        hStack.addArrangedSubview(radioButton)
        hStack.addArrangedSubview(vStack)
        
        
        contentView.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: cellSpacing),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -cellSpacing)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        taskTitleLabel.attributedText = nil
    }
    
}
