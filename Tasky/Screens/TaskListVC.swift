//
//  TaskListVC.swift
//  Tasky
//
//  Created by Archana Kumari on 11/08/25.
//

import UIKit

class TaskListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureRightButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    func configureRightButton() {
        let customButton = UIButton(type: .system)
        customButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        customButton.setTitle("Add List Item", for: .normal)
        customButton.addTarget(self, action: #selector(pushAddTaskListVC), for: .touchUpInside)

        let customBarButtonItem = UIBarButtonItem(customView: customButton)

        navigationController?.navigationBar.topItem?.rightBarButtonItem = customBarButtonItem
    }
    
    @objc func pushAddTaskListVC() {
        let addTaskListVC = AddTaskListVC()
        addTaskListVC.navigationItem.title = "Add New List"
        navigationController?.pushViewController(addTaskListVC, animated: true)
    }
}
