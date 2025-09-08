//
//  BottomSheetUIView.swift
//  Tasky
//
//  Created by Rishabh Kumar on 29/08/25.
//

import UIKit

class BottomSheetUIView:UIViewController {
    let TaskField = TaskTextField(placeholderText: "Enter Task Name")
    let cancelButton = TaskyButton(backgroundColor: .systemRed, title: "Cancel")
    let AddButton = TaskyButton(backgroundColor: .systemOrange, title: "Add Task", titleColor: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTaskField()
        configureAddButton()
        configureCancelButton()
    }
    
    @objc func addButtonTapped(){
        TaskField.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped(){
        TaskField.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureTaskField(){
        view.addSubview(TaskField)
        
        NSLayoutConstraint.activate([
            TaskField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            TaskField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            TaskField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            TaskField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureAddButton(){
        view.addSubview(AddButton)
        AddButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            AddButton.topAnchor.constraint(equalTo: TaskField.bottomAnchor, constant: 15),
            AddButton.trailingAnchor.constraint(equalTo: TaskField.trailingAnchor),
            AddButton.widthAnchor.constraint(equalToConstant: 175),
            AddButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureCancelButton(){
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: TaskField.bottomAnchor, constant: 15),
            cancelButton.leadingAnchor.constraint(equalTo: TaskField.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 175),
            cancelButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
