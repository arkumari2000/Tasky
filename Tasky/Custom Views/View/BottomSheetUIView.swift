//
//  BottomSheetUIView.swift
//  Tasky
//
//  Created by Rishabh Kumar on 29/08/25.
//

import UIKit

protocol BottomSheetUIViewDelegate: AnyObject {
    func addButtonTapped(withText text: String?)
}

class BottomSheetUIView: UIViewController {
    let taskField = TaskTextField(placeholderText: "Enter Task Name")
    let cancelButton = TaskyButton(backgroundColor: .systemRed, title: "Cancel")
    let addButton = TaskyButton(backgroundColor: .systemOrange, title: "Add Task", titleColor: .white)
    
    var delegate: BottomSheetUIViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTaskField()
        configureAddButton()
        configureCancelButton()
    }
    
    @objc func addButtonTapped(){
        delegate?.addButtonTapped(withText: taskField.text)
        taskField.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped(){
        taskField.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureTaskField(){
        view.addSubview(taskField)
        let sidePadding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            taskField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            taskField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            taskField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            taskField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureAddButton(){
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: taskField.bottomAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: taskField.trailingAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 175),
            addButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureCancelButton(){
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: taskField.bottomAnchor, constant: 15),
            cancelButton.leadingAnchor.constraint(equalTo: taskField.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 175),
            cancelButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
