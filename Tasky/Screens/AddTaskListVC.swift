//
//  AddTaskListVC.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class AddTaskListVC: UIViewController {

    let textField = TaskTextField(placeholderText: "Enter List Name")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configureViews() {
        configureTextField()
    }

    func configureTextField() {
        view.addSubview(textField)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
